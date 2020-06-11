//
//  AccountDetailView.swift
//  ViewModelAsValue
//
//  Created by Farley Caesar on 2020-06-07.
//  Copyright © 2020 PureFunc. All rights reserved.
//

import SwiftUI

struct AccountDetailsView: View {
    let accountDetailsViewModel: AccountDetailsViewModel
    
    var body: some View {
        VStack {
            accountNumber
            
            Spacer()
            
            accountNickName
                .padding()
            
            accountType
                .padding()

            accountBalance
                .padding()
            
            doneButton
            
            Spacer()
        }
    }
}

// MARK: Body Components
private extension AccountDetailsView {
    var accountNumber: some View {
        Text("\(accountDetailsViewModel.accountNumber)")
            .font(.largeTitle)
    }
    
    var accountNickName: some View {
        Text("\(accountDetailsViewModel.nickName)")
            .bold()
    }
    
    var accountType: some View {
        Text("\(accountDetailsViewModel.accountType)")
    }
    
    var accountBalance: some View {
       Text("\(accountDetailsViewModel.balance)")
    }
    
    var doneButton: some View {
        Button(action: {
            self.accountDetailsViewModel.done()
        }) {
            Text("Done")
        }
    }
}

struct AccountDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        accountDetailsView()
    }
    
    static func accountDetailsView() -> AnyView {
        guard let account = Account.mockAccountList.first else {
            return AnyView(Text("No Account"))
        }
        
        let accountDetailsViewModel =
            AccountDetailsViewModel(
                account: account,
                done: {})
        
        return AnyView(AccountDetailsView(accountDetailsViewModel: accountDetailsViewModel))
    }
}
