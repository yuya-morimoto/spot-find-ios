//
//  AuthReducer.swift
//  spot-find
//
//  Created by Yuya Morimoto on R 5/04/22.
//

import ComposableArchitecture
import FirebaseAuth

struct AuthReducer: ReducerProtocol {
    func reduce(into state: inout AuthState, action: AuthAction) -> EffectTask<AuthAction> {
        switch action {
        case .updateCurrentUser:
            state.currentUser = AuthState.auth.currentUser
            return .none

        case let .createUserStart(email, password):
            state.createaUserApiStatus.stepPending()
            return .task(operation: { .createUserExecute(email: email, password: password) })

        case let .createUserExecute(email, password):
            return .run { send in
                self.createUser(email: email, password: password) { result in
                    switch result {
                    case .success:
                        Task { @MainActor in send(.signOutStatus(step: .success(nil))) }
                    case .failure:
                        Task { @MainActor in send(.signOutStatus(step: .success(nil))) }
                    }
                }
            }

        case let .createUserEnd(result):
            switch result {
            case .success:
                state.createaUserApiStatus.stepSuccess(result: nil)
            case let .failure(error):
                state.createaUserApiStatus.stepFailed(error: error)
            }
            return .none

        case .signOut:
            do {
                try AuthState.auth.signOut()
                // サインアウト処理完了後にcurrentUserを更新する
                return .task(operation: { .updateCurrentUser })
            } catch let signOutError as NSError {
                // return .task(operation: { .signOutStatus(step: .failed(ErrorState.createFireBaseAuthErrorModel(error: signOutError))) })
                return .none
            }
        case let .createUserStatus(nextStep):
            switch nextStep {
            case .waiting:
                state.createaUserApiStatus.stepWaiting()
            case .pending:
                state.createaUserApiStatus.stepPending()
                return .none
            case let .success(result):
                state.createaUserApiStatus.stepSuccess(result: result)
            case let .failed(error):
                state.createaUserApiStatus.stepFailed(error: error)
            }
            return .none

        case let .signOutStatus(step):
            switch step {
            case .pending:
                state.signOutApiStatus.stepPending()
            case .waiting:
                state.signOutApiStatus.stepWaiting()
            case let .success(result):
                state.signOutApiStatus.stepSuccess(result: result)
            case let .failed(error):
                state.signOutApiStatus.stepFailed(error: error)
            }
            return .none
        }
    }
}

extension AuthReducer {
    func createUser(
        email: String,
        password: String,
        completion: @escaping (Result<Bool, ErrorState>) -> Void
    ) {
        Auth.auth().createUser(withEmail: email, password: password) {
            result, error in if error == nil {
                if let user = result?.user {
                    user.sendEmailVerification { error in
                        if error != nil {
                            completion(.failure(ErrorState.sendEmailVerificatioinError))
                        } else {
                            completion(.success(true))
                        }
                    }
                } else {
                    completion(.failure(ErrorState.userNotFound))
                }
            } else {
                let error = error! as NSError
                completion(.failure(ErrorState.codeToErrorState(code: error.code)))
            }
        }
    }
}
