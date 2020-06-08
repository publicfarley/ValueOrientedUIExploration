//
//  LoginView.swift
//  ViewModelAsValue
//
//  Created by Farley Caesar on 2020-06-05.
//  Copyright © 2020 PureFunc. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    let loginViewModel: LoginViewModel
    
    @Binding var isLoggedIn: Bool
    
    static let initialGreeting = "Welcome to the App"
    @State private var message: String = Self.initialGreeting
    
    var body: some View {
        VStack {
            Text(self.message)
                .padding()
            
            Button(action: {
                self.loginViewModel.signIn(with: self.loginStateHandler)
            }) {
                Text("Login")
            }.disabled(message != Self.initialGreeting)
             .padding()
        }
    }
    
    func loginStateHandler(handle state: LoginViewModel.LoginState) {
        switch state {
        case .unAuthenticated:
            message = "Login"
        case .inTheProcessOfAuthenticating:
            message = "Authenticating"
        case .error(let authenticationError):
            message = "\(authenticationError)"
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
               self.message = Self.initialGreeting
            }
            
        case .authenticated:
            message = "Success! You're in!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.isLoggedIn = true
            }
        }
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
