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
    @State private var statusMessage: String = ""
    @State private var isError: Bool = false
    @State private var status: LoginViewModel.AuthenticationState = .unAuthenticated
    
    var body: some View {
        VStack {
            VStack {
                Text("Welcome to Accounts!")
                    .font(.title)
                    .padding(.top, 20)
                
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fit)
                    .foregroundColor(isError ? .red : .primary)
                    .frame(width: 150, height: 150)
                    .padding(.bottom, 20)
                    .padding(.top, 25)
            }
            .scaleEffect(status == .authenticated ? 0 : 1)
            .animation(status == .authenticated
                ? .spring()
                : .interpolatingSpring(mass: 1.0,stiffness: 100.0,damping: 10,initialVelocity: 0))

            ActivityIndicator()
                .opacity(status == .inTheProcessOfAuthenticating ? 1 : 0)

            if status == .authenticated {
                Text(Self.successMessage)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(height: 20)
            }
            
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
                }.disabled(userID.count == 0 || password.count == 0 || status != .unAuthenticated)
                 .padding()
            }
            .scaleEffect(status == .authenticated ? 0 : 1)
            .animation(status == .authenticated
                ? .spring()
                : .interpolatingSpring(mass: 1.0,stiffness: 100.0,damping: 10,initialVelocity: 0))
            
            Spacer()
        }
        .keyboardAwarePadding()
        .alert(isPresented: $isError) {
            Alert(title: Text("Authentication Error"),
                  message: Text("\(statusMessage)"),
                  dismissButton: .default(Text("OK"), action: { self.setToInitialState() }))
        }
    }
    
    func loginStateHandler(handle state: LoginViewModel.AuthenticationState) {
        status = state

        switch state {
        case .unAuthenticated:
            statusMessage = ""
        
        case .inTheProcessOfAuthenticating:
            statusMessage = "Authenticating"
        
        case .error(let authenticationError):
            isError = true
            statusMessage = "\(toMessage(from: authenticationError))"
            
        case .authenticated:
            let twoSeconds: Double = 2
            DispatchQueue.main.asyncAfter(deadline: .now() + twoSeconds) {
                self.isLoggedIn = true
            }
        }
    }
    
    private func setToInitialState() {
        self.status = .unAuthenticated
        self.isError = false
        self.statusMessage = ""
        self.userID = ""
        self.password = ""
    }
    
    private func toMessage(from error: Error) -> String {
        switch error {
        case AuthenticationError.invalidCredentials:
            return "Your userID or password was incorrect. Please try again."
        case AuthenticationError.invalidUserIDLength(_, let expectedCharacterCount):
            return "Your userID was less than the required \(expectedCharacterCount) characters. Please try again."
        case AuthenticationError.unexpectedError:
            fallthrough
        default:
            return "We are experiencing technical issues. Please try again."
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

