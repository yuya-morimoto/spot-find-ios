//
//  AuthState.swift
//  spot-find
//
//  Created by Yuya Morimoto on R 5/04/22.
//

import ComposableArchitecture
import FirebaseAuth
import SwiftUI

struct AuthState: Equatable {
    // メールアドレス認証後の検知用
    var isEmailVerified: Bool
    var createaUserApiStatus: CreateUserApiStatus = .init()
    var sendEmailVerificationApiStatus: SendEmailVerificationApiStatus = .init()
    var signInApiStatus: SignInApiStatus = .init()
    var signOutApiStatus: SignOutApiStatus = .init()

    init() {
        if let user = Auth.auth().currentUser {
            self.isEmailVerified = user.isEmailVerified
        } else {
            self.isEmailVerified = false
        }
    }
}

typealias CreateUserApiStatus = ApiStatusState<AuthDataResult>
typealias SendEmailVerificationApiStatus = ApiStatusState<Bool>
typealias SignInApiStatus = ApiStatusState<AuthDataResult>
typealias SignOutApiStatus = ApiStatusState<Bool>
