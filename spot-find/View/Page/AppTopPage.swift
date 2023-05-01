//
//  AppTopPage.swift
//  spot-find
//
//  Created by Yuya Morimoto on R 5/04/22.
//

import ComposableArchitecture
import SwiftUI

struct AppTopPage: View {
    let store: AppStore

    var body: some View {
        WithViewStore(self.store, observe: \.auth) { viewStore in
            Button("sign out") {
                viewStore.send(.auth(.signOut))
            }
        }
    }
}
