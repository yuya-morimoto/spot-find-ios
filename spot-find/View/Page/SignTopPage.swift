//
//  SignTopPage.swift
//  spot-find
//
//  Created by Yuya Morimoto on R 5/04/22.
//

import ComposableArchitecture
import FirebaseAuth
import SwiftUI

struct SignTopPage: View {
    @State private var signUpSheet = false

    let store: StoreOf<AuthReducer>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Spacer()
                Image(Image.AppIntroIcon)
                Text("Welcome to SpotFind.")
                    .foregroundColor(Color.Primary)
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
                VStack {
                    SignInSheetToggleButton(sheetPage: SignInPage(viewStore: viewStore), viewStore: viewStore)
                    SignUpSheetToggleButton(sheetPage: SignUpPage(viewStore: viewStore), viewStore: viewStore)
                }
            }
            .padding()
        }.background(Color.BackgroundColor)
    }
}
