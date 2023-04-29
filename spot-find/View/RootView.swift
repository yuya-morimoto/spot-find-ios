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
    let store: Store<AuthState, AuthAction>

    init() {
        self.store = Store(initialState: AuthState(), reducer: AuthReducer())
    }

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { _ in
            if Auth.auth().currentUser != nil {
                AppTopPage(store: self.store)
            } else {
                SignTopView(store: self.store)
            }
        }
    }
}
