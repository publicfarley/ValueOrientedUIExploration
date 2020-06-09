//
//  LoginView.swift
//  ViewModelAsValue
//
//  Created by Farley Caesar on 2020-06-05.
//  Copyright © 2020 PureFunc. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    static let successMessage = "You're in!"

    let loginViewModel: LoginViewModel
    
    @Binding var isLoggedIn: Bool
    
    @State private var userID: String = ""
    @State private var password: String = ""
    @State private var statusMessage: String = " "
    @State private var isError: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                Text("Welcome to the App")
                    .padding(.top, 20)
                
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fit)
                    .foregroundColor(isError ? .red : .primary)
                    .frame(width: 150, height: 150)
                    .padding(.bottom, 20)
                    .padding(.top, 25)
            }
            .scaleEffect(statusMessage == Self.successMessage ? 0 : 1)
            .animation(statusMessage == Self.successMessage
                ? .spring()
                : .interpolatingSpring(mass: 1.0,stiffness: 100.0,damping: 10,initialVelocity: 0))

            ActivityIndicator()
                .opacity(statusMessage == "Authenticating" ? 1 : 0)

            Text(statusMessage)
                .foregroundColor(isError ? .red : .primary)
                .frame(height: 20)
            
            VStack {
                VStack(spacing: 10) {
                    TextField("username", text: $userID)
                    SecureField("password", text: $password)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                
                Button(action: {
                    
                    UIApplication.shared.windows
                        .first { $0.isKeyWindow }?
                        .endEditing(true)
                    
                    self.loginViewModel.authenticate(userID: self.userID,
                                                     password: self.password,
                                                     with: self.loginStateHandler)
                }) {
                    Text("Login")
                }.disabled(userID.count == 0 ||
                           password.count == 0 ||
                           statusMessage != " ")
                 .padding()
            }
            .scaleEffect(statusMessage == Self.successMessage ? 0 : 1)
            .animation(statusMessage == Self.successMessage
                ? .spring()
                : .interpolatingSpring(mass: 1.0,stiffness: 100.0,damping: 10,initialVelocity: 0))
            
            Spacer()
        }
        .keyboardAwarePadding()
    }
    
    func loginStateHandler(handle state: LoginViewModel.AuthenticationState) {
        switch state {
        case .unAuthenticated:
            statusMessage = " "
        
        case .inTheProcessOfAuthenticating:
            statusMessage = "Authenticating"
        
        case .error(let authenticationError):
            isError = true
            statusMessage = "\(authenticationError)"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.setToInitialState()
            }
            
        case .authenticated:
            statusMessage = Self.successMessage
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isLoggedIn = true
            }
        }
    }
    
    private func setToInitialState() {
        self.isError = false
        self.statusMessage = " "
        self.userID = ""
        self.password = ""
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        loginView()
    }
    
    static func loginView() -> some View {
        let loginViewModel = LoginViewModel()
        
        return LoginView(loginViewModel: loginViewModel,
                         isLoggedIn: .constant(false))
    }
}
