//
//  AuthAction.swift
//  spot-find
//
//  Created by Yuya Morimoto on R 5/04/22.
//

import ComposableArchitecture
import FirebaseAuth

enum AuthAction: Equatable {
    // MARK: - create user

    case createUser(email: String, password: String)
    case onCreateUserResponse(TaskResult<AuthDataResult>)

    // MARK: - send email verification

    case sendEmailVerification
    case onSendEmailVerificationResponse(TaskResult<Bool>)
    
    // MARK: - sign in

    case signIn(email: String, password: String)
    case onSignInResponse(TaskResult<AuthDataResult>)

    // MARK: - sign out

    case signOut
    case onSignOutResponse(TaskResult<Bool>)
}
