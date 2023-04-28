//
//  ContentView.swift
//  spot-find
//
//  Created by Yuya Morimoto on R 5/04/22.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    let store: StoreOf<AuthReducer>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { _ in
            VStack {
                Spacer()
                SignTopView(store: store)
                Spacer()
            }
            .padding()
        }
    }
}
