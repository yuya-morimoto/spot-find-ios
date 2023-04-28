//
//  SignUpPage.swift
//  spot-find
//
//  Created by Yuya Morimoto on R 5/04/23.
//

import ComposableArchitecture
import SwiftUI

struct SignUpPage: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var isCreated: Bool = false

    let store: StoreOf<AuthReducer>

    var signUpButtonBgColor: Color {
        if email == "" || password == "" {
            return .DisableColor
        }
        return .Primary
    }

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                if isCreated {
                    VStack {
                        Text(email + "宛に確認用のメールを送信しました。")
                    }
                } else {
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Create Account.")
                                    .foregroundColor(.Primary)
                                    .font(.title)
                                    .fontWeight(.bold)
                                Text("create with email.")
                                    .foregroundColor(Color.gray.opacity(0.6))
                            }
                            Spacer()
                        }.padding()
                        Spacer()
                        VStack {
                            VStack(alignment: .leading) {
                                Text("メールアドレス")
                                    .foregroundColor(.ForegroundColor)
                                    .font(.callout)
                                TextField("example@spot-find.jp", text: $email)
                                    .foregroundColor(.ForegroundColor)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                    .font(.callout)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(maxWidth: .infinity)
                            }
                            VStack(alignment: .leading) {
                                Text("パスワード")
                                    .foregroundColor(.ForegroundColor)
                                    .font(.callout)
                                SecureField("8-16文字の半角英数字", text: $password)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.alphabet)
                                    .font(.callout)
                            }.padding(.top)
                            ErrorText()
                            Button(action: {
                                viewStore.send(.createUserStart(email: email, password: password))
                            }, label: {
                                Text("アカウントを作成")
                                    .frame(maxWidth: .infinity)
                            })
                            .frame(maxWidth: .infinity)
                            .disabled(email == "" || password == "")
                            .padding(.top)
                            if viewStore.createaUserApiStatus.status == .waiting {
                                Text("waiting...")
                            } else if viewStore.createaUserApiStatus.status == .pending {
                                Text("pending...")
                            } else if viewStore.createaUserApiStatus.status == .success {
                                Text("pending...")
                            } else {
                                Text("error...")
                            }

                            if viewStore.createaUserApiStatus.status == .success {
                                Text("success")
                            }

                            if viewStore.createaUserApiStatus.status == .failed {
                                Text("failed")
                            }
                        }
                        Spacer()
                    }
                    .padding(30)
                }
            }
        }
    }
}
