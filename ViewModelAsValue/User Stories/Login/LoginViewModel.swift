//
//  LoginViewModel.swift
//  ViewModelAsValue
//
//  Created by Farley Caesar on 2020-06-05.
//  Copyright © 2020 PureFunc. All rights reserved.
//

import Foundation

struct UserID {
    let value: String
    let validLength = 8
    
    init(value: String) throws {
        let receivedUserIDLength = value.count
        
        guard receivedUserIDLength >= validLength else {
            throw AuthenticationError.invalidUserIDLength(received: receivedUserIDLength,
                                                          expected: validLength)
        }
        
        self.value = value
    }
}

struct Password {
    let value: String
}

struct Credentials {
    let userID: UserID
    let password: Password
}

enum AuthenticationError: Error {
    case invalidUserIDLength(received: Int, expected: Int)
    case invalidCredentials
    case unexpectedError
}

struct LoginViewModel {
    enum AuthenticationState {
        case unAuthenticated
        case inTheProcessOfAuthenticating
        case error(Error)
        case authenticated
    }
    
    enum TimeOfDay {
        case morning
        case day
        case evening
    }
    
    func authenticate(userID: String, password: String, with authenticationStateHandler: @escaping (AuthenticationState) -> Void) {
        do {
            let userID = try UserID(value: userID)
            let password = Password(value: password)
            
            let credentials = Credentials(userID: userID, password: password)
            
            signIn(using: credentials, with: authenticationStateHandler)
        } catch {
            authenticationStateHandler(.error(error))
        }
    }
    
    private func signIn(using credentials: Credentials,
                        with authenticationStateHandler: @escaping (AuthenticationState) -> Void) {
        
        authenticationStateHandler(.inTheProcessOfAuthenticating)
        
        // Simulate Server call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            
            if let authenticationError = self.validate(credentials: credentials) {

                authenticationStateHandler(.error(authenticationError))
                    
                return
            }

            authenticationStateHandler(.authenticated)
        }
    }
    
    private func validate(credentials: Credentials) -> AuthenticationError? {
        guard credentials.password.value.caseInsensitiveCompare("password") == .orderedSame else {
            return .invalidCredentials
        }
        
        return nil
    }
}

extension LoginViewModel.AuthenticationState: Equatable {
    static func == (lhs: LoginViewModel.AuthenticationState, rhs: LoginViewModel.AuthenticationState) -> Bool {
        switch (lhs,rhs) {
        case (.unAuthenticated, .unAuthenticated): return true
        case (.authenticated, .authenticated): return true
        case (.inTheProcessOfAuthenticating, .inTheProcessOfAuthenticating): return true
        default: return false // Note: We are just saying that errors with associated values will be false, since the value may not be equatable
        }
    }
}

