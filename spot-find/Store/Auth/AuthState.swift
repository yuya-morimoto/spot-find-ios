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
    static let auth: Auth = .auth()
    var currentUser: User?
    var createaUserApiStatus: CreateUserApiStatus = .init()
    var signOutApiStatus: SignOutApiStatus = .init()
}
