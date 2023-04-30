//
//  WaitingEmailVerificationPage.swift
//  spot-find
//
//  Created by Yuya Morimoto on R 5/04/29.
//

import ComposableArchitecture
import SwiftUI

struct WaitingEmailVerificationPage: View {
    var viewStore: ViewStoreOf<AuthReducer>

    var body: some View {
        Text("waiting email verification...")
        if let user = viewStore.currentUser {
            if let email = user.email {
                Text(email + "宛に認証用メールを送信しました。")
                if viewStore.isEmailVerified {
                    Text("true")
                } else {
                    Text("false")
                    Button("sign out") {
                        viewStore.send(.signOut)
                    }
                }
                Button("reload") {
                    viewStore.send(.checkEmailVerification)
                }
            }
        } else {
            Text("undefined")
        }
    }
}
