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
                title
                personImage
            }
            .scaleEffect(status == .authenticated ? 0 : 1)
            .animation(status == .authenticated
                ? .spring()
                : .interpolatingSpring(mass: 1.0,stiffness: 100.0,damping: 10,initialVelocity: 0))

            ActivityIndicator()
                .opacity(status == .inTheProcessOfAuthenticating ? 1 : 0)

            if status == .authenticated {
                successMessage
            }
            
            VStack {
                userNameAndPassword
                submitButton
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
                  dismissButton: .default(Text("OK"), action: { self.doSetToInitialState() }))
        }
    }
}
    
// MARK: Body Components
private extension LoginView {
    var title: some View {
        Text("Welcome to Accounts!")
            .font(.title)
            .padding(.top, 20)
    }
    
    var personImage: some View {
        Image(systemName: "person.crop.circle")
            .resizable()
            .aspectRatio(contentMode: ContentMode.fit)
            .foregroundColor(isError ? .red : .primary)
            .frame(width: 150, height: 150)
            .padding(.bottom, 20)
            .padding(.top, 25)
    }
    
    var successMessage: some View {
        Text(Self.successMessage)
            .fixedSize(horizontal: false, vertical: true)
            .frame(height: 20)
    }
    
    var userNameAndPassword: some View {
        VStack(spacing: 10) {
            TextField("username", text: $userID)
            SecureField("password", text: $password)
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.horizontal)
    }
    
    var submitButton: some View {
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
}

// MARK: Helper methods
private extension LoginView {
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
    
    func doSetToInitialState() {
        self.status = .unAuthenticated
        self.isError = false
        self.statusMessage = ""
        self.userID = ""
        self.password = ""
    }
    
    func toMessage(from error: Error) -> String {
        switch error {
        case AuthenticationError.invalidCredentials:
            return "Your userID or password was incorrect.\nPlease try again."
        case AuthenticationError.invalidUserIDLength(_, let expectedCharacterCount):
            return "Your userID was less than the required \(expectedCharacterCount) characters.\nPlease try again."
        case AuthenticationError.unexpectedError:
            fallthrough
        default:
            return "We are experiencing technical issues.\nPlease try again."
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

