//
//  AuthType.swift
//  spot-find
//
//  Created by Yuya Morimoto on R 5/04/23.
//

import FirebaseAuth

typealias CreateUserApiStatus = ApiStatusState<AuthDataResult>

typealias SendEmailVerificationApiStatus = ApiStatusState<Bool>

typealias SignInApiStatus = ApiStatusState<AuthDataResult>

typealias SignOutApiStatus = ApiStatusState<Bool>
