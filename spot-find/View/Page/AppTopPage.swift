//
//  AppTopPage.swift
//  spot-find
//
//  Created by Yuya Morimoto on R 5/04/22.
//

import ComposableArchitecture
import SwiftUI

struct AppTopPage: View {
    let viewStore: ViewStore<AuthState, AuthAction>

    var body: some View {
        Text("app top page")
        Button("sign out") {
            viewStore.send(.signOut)
        }
    }
}
