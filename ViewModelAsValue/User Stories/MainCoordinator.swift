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
            if !isLoggedIn {
                loginView
                    .transition(.backwardScreenTransition)
            } else {
                landingScreen
                    .transition(.forwardScreenTransition)
                    .animation(.default)
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
