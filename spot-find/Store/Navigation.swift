//
//  Navigation.swift
//  spot-find
//
//  Created by Yuya Morimoto on R 5/04/22.
//

import ComposableArchitecture
import FirebaseAuth
import SwiftUI

struct Navigation: ReducerProtocol {
    struct State: Equatable {
        let auth: Auth = .auth()
        var currentUser: User?
        var isTest: Bool = false
    }

    enum Action: Equatable {
        case getCurrentUser
        case toggleTest
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .getCurrentUser:
            state.currentUser = state.auth.currentUser
            return .none
        case .toggleTest:
            state.isTest = !state.isTest
            return .none
        }
    }
}
