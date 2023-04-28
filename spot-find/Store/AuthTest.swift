//
//  Auth.swift
//  spot-find
//
//  Created by Yuya Morimoto on R 5/04/22.
//

import ComposableArchitecture
import FirebaseAuth
import SwiftUI

struct AuthTest: ReducerProtocol {
    enum Action: Equatable {
        case getCurrentUser
        case toggleTest
    }

    struct State {
        var currentUser: User?
        var isTest: Bool = false
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .getCurrentUser:
            return .none
        case .toggleTest:
            state.isTest = !state.isTest
            return .none
        }
    }
}
