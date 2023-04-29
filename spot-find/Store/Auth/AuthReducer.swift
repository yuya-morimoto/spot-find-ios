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
            // MARK: - create user

        case let .createUser(email, password):
            state.createaUserApiStatus.stepPending()
            return .task {
                .onCreateUserResponse(
                    await TaskResult {
                        try await self.createUser(email: email, password: password)
                    }
                )
            }
        case let .onCreateUserResponse(.success(result)):
            state.createaUserApiStatus.stepSuccess(result: result)
            return .task(operation: { .sendEmailVerification(user: result.user) })
        case let .onCreateUserResponse(.failure(error)):
            let error = error as NSError
            state.createaUserApiStatus.stepFailed(error: ErrorState.codeToErrorState(code: error.code))
            return .none

            // MARK: - send email verification

        case let .sendEmailVerification(user):
            state.sendEmailVerificationApiStatus.stepPending()
            return .task {
                .onSendEmailVerificationResponse(
                    await TaskResult {
                        try await self.sendEmailVerification(user: user)
                    })
            }
        case let .onSendEmailVerificationResponse(.success(result)):
            state.sendEmailVerificationApiStatus.stepSuccess(result: result)
            return .task(operation: { .signOut })
        case let .onSendEmailVerificationResponse(.failure(error)):
            let error = error as NSError
            state.sendEmailVerificationApiStatus.stepFailed(error: ErrorState.codeToErrorState(code: error.code))
            return .none

            // MARK: - sign in

        case let .signIn(email, password):
            state.signOutApiStatus.stepPending()
            return .task {
                .onSignInResponse(
                    await TaskResult {
                        try await self.signIn(email: email, password: password)
                    })
            }
        case let .onSignInResponse(.success(result)):
            state.signInApiStatus.stepSuccess(result: result)
            return .none
        case let .onSignInResponse(.failure(error)):
            let error = error as NSError
            state.signInApiStatus.stepFailed(error: ErrorState.codeToErrorState(code: error.code))
            return .none

            // MARK: - sign out

        case .signOut:
            state.signOutApiStatus.stepPending()
            return .task {
                .onSignOutResponse(
                    await TaskResult {
                        try await self.signOut()
                    })
            }
        case let .onSignOutResponse(.success(result)):
            state.signOutApiStatus.stepSuccess(result: result)
            return .none
        case let .onSignOutResponse(.failure(error)):
            let error = error as NSError
            state.signOutApiStatus.stepFailed(error: ErrorState.codeToErrorState(code: error.code))
            return .none
        }
    }
}

extension AuthReducer {
    @MainActor
    func createUser(email: String, password: String) async throws -> AuthDataResult {
        do {
            return try await AuthState.auth.createUser(withEmail: email, password: password)
        } catch {
            throw error
        }
    }

    @MainActor
    func sendEmailVerification(user: User) async throws -> Bool {
        do {
            try await user.sendEmailVerification()
            return true
        } catch {
            throw error
        }
    }

    @MainActor
    func signIn(email: String, password: String) async throws -> AuthDataResult {
        do {
            return try await AuthState.auth.signIn(withEmail: email, password: password)
        } catch {
            throw error
        }
    }

    @MainActor
    func signOut() async throws -> Bool {
        do {
            try AuthState.auth.signOut()
            return true
        } catch {
            throw error
        }
    }
}
