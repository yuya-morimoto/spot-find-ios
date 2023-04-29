//
//  AppTopPage.swift
//  spot-find
//
//  Created by Yuya Morimoto on R 5/04/22.
//

import ComposableArchitecture
import SwiftUI

struct AppTopPage: View {
    let store: StoreOf<AuthReducer>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Button("sign out") {
                viewStore.send(.signOut)
            }
        }
    }
}
