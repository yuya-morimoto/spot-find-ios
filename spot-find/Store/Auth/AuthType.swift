//
//  AuthType.swift
//  spot-find
//
//  Created by Yuya Morimoto on R 5/04/23.
//

import FirebaseAuth

typealias CreateUserResult = AuthDataResult
typealias CreateUserApiStatus = ApiStatusState<CreateUserResult>

typealias SendEmailVerificationResult = Bool
typealias SendEmailVerificationApiStatus = ApiStatusState<SendEmailVerificationResult>

typealias SignInResult = AuthDataResult
typealias SignInApiStatus = ApiStatusState<SignInResult>

typealias SignOutResult = Bool
typealias SignOutApiStatus = ApiStatusState<SignOutResult>
