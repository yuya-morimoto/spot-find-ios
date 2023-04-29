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
    case onCreateUserResponse(TaskResult<CreateUserResult>)

    // MARK: - send email verification

    case sendEmailVerification(user: User)
    case onSendEmailVerificationResponse(TaskResult<SendEmailVerificationResult>)
    
    // MARK: - sign in

    case signIn(email: String, password: String)
    case onSignInResponse(TaskResult<SignInResult>)

    // MARK: - sign out

    case signOut
    case onSignOutResponse(TaskResult<SignOutResult>)
}
