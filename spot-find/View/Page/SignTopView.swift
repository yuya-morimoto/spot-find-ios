//
//  SignTopView.swift
//  spot-find
//
//  Created by Yuya Morimoto on R 5/04/22.
//

import ComposableArchitecture
import SwiftUI

struct SignTopView: View {
    @State private var signInSheet = false
    @State private var signUpSheet = false

    let store: StoreOf<AuthReducer>

    init(store: StoreOf<AuthReducer>) {
        self.store = store
    }

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack {
                    Text("Welcome to SpotFind.")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                Spacer()
                VStack {
                    Button(action: {
                        signInSheet.toggle()
                    }, label: {
                        Text("ログイン")
                            .frame(maxWidth: .infinity)
                    })
                    .padding(.horizontal, 30)
                    .sheet(isPresented: $signInSheet, onDismiss: {}) {
                        Text("sign in user")
                    }
                    Button(action: {
                        signUpSheet.toggle()
                    }, label: {
                        Text("アカウントを作成する")
                            .frame(maxWidth: .infinity)
                    })
                    .padding(.horizontal, 30)
                    .sheet(isPresented: $signUpSheet, onDismiss: {}) {
                        SignUpPage(store: self.store)
                    }
                }
            }
            .padding()
        }
    }
}
