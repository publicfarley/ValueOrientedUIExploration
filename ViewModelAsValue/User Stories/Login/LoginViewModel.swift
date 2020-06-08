//
//  LoginViewModel.swift
//  ViewModelAsValue
//
//  Created by Farley Caesar on 2020-06-05.
//  Copyright © 2020 PureFunc. All rights reserved.
//

import Foundation

struct Credentials {
    let userID: String
    let password: String
}
enum AuthenticationError {
    case invalidCredentials
}

struct LoginViewModel {
    enum LoginState {
        case unAuthenticated
        case inTheProcessOfAuthenticating
        case error(AuthenticationError)
        case authenticated
    }
    
    enum TimeOfDay {
        case morning
        case day
        case evening
    }
    
    func signIn(with loginStateHandler: @escaping (LoginState) -> Void) {
        loginStateHandler(.inTheProcessOfAuthenticating)
        
        // Simulate Server call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            
            if let authenticationError =
                self.validate(credentials: Credentials(userID: "username",
                                                       password: "password")) {

                loginStateHandler(.error(authenticationError))
                    
                return
            }

            loginStateHandler(.authenticated)
        }
    }
    
    private func validate(credentials: Credentials) -> AuthenticationError? {
        nil
        //Bool.random() ? nil : .invalidCredentials
    }
}
