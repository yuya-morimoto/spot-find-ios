//
//  AuthAction.swift
//  spot-find
//
//  Created by Yuya Morimoto on R 5/04/22.
//

import ComposableArchitecture

enum AuthAction: Equatable {
    case updateCurrentUser
    case createUserStart(email: String, password: String)
    case createUserExecute(email: String, password: String)
    case createUserEnd(_ result: Result<Bool, ErrorState>)
    case createUserStatus(nextStep: ApiStatusAction<CreateUserResult>)
    case signOut
    case signOutStatus(step: ApiStatusAction<SignOutResult>)
}
