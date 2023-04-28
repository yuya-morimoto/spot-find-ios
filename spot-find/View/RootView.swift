//
//  RootView.swift
//  spot-find
//
//  Created by Yuya Morimoto on R 5/04/22.
//

import ComposableArchitecture
import SwiftUI

struct RootView: View {
    let store: Store<AuthState, AuthAction>

    init() {
        self.store = Store(initialState: AuthState(), reducer: AuthReducer())
    }

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            if viewStore.currentUser != nil {
                AppTopPage(viewStore: viewStore)
            } else {
                SignTopView(store: self.store)
            }
        }
    }
}
