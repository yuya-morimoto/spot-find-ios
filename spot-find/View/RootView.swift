//
//  RootView.swift
//  spot-find
//
//  Created by Yuya Morimoto on R 5/04/22.
//

import ComposableArchitecture
import FirebaseAuth
import SwiftUI

struct RootView: View {
    var store: StoreOf<AuthReducer>

    init() {
        self.store = Store(initialState: AuthState(), reducer: AuthReducer())
    }

    var body: some View {
        WithViewStore(self.store) { viewStore in
            if let user = viewStore.currentUser {
                if user.isEmailVerified == true || viewStore.isEmailVerified == true {
                    AppTopPage(store: self.store)
                } else {
                    WaitingEmailVerificationPage(viewStore: viewStore)
                }
            } else {
                SignTopPage(store: self.store)
            }
        }
    }
}
