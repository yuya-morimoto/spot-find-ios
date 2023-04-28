//
//  SignInPage.swift
//  spot-find
//
//  Created by Yuya Morimoto on R 5/04/23.
//

import SwiftUI

struct SignInPage: View {
    @State var isSignIn = false
    
    @State var email: String = ""
    @State var password: String = ""
    
    var signUpButtonBgColor: Color {
        if email == "" || password == "" {
            return Color.DisableColor
        }
        return Color.Primary
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Welcome Back!")
                        .foregroundColor(Color.Primary)
                        .font(.title)
                        .fontWeight(.bold)
                    Text("login with email.")
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
                
                Spacer()
            }
            .padding(30)
        }
    }
}
