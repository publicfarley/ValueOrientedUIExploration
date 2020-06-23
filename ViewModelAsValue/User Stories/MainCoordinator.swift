//
//  ContentView.swift
//  ViewModelAsValue
//
//  Created by Farley Caesar on 2020-06-04.
//  Copyright © 2020 PureFunc. All rights reserved.
//

import SwiftUI

struct MainCoordinator: View {
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        VStack {
            switch isLoggedIn {
            
            case false:
                loginView
                    .transition(.forwardScreenTransition)
            
            case true:
                landingScreen
                    .transition(.move(edge: .bottom))
            }
        }
    }
}

// MARK: Body Components
private extension MainCoordinator {
    var loginView: some View {
        LoginView(loginViewModel: LoginViewModel(), isLoggedIn: $isLoggedIn)
    }
    
    var landingScreen: some View {
        VStack {
            AccountDisplayCoordinator()
            
            Spacer()
            
            Button(action: { withAnimation { self.isLoggedIn = false } }) {
                Text("Logout")
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainCoordinator()
    }
}
