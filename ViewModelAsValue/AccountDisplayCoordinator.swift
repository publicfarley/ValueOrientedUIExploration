//
//  AccountManipulationCoordinator.swift
//  ViewModelAsValue
//
//  Created by Farley Caesar on 2020-06-06.
//  Copyright © 2020 PureFunc. All rights reserved.
//

import SwiftUI

struct AccountDisplayCoordinator: View {
    @State private var selectedAccountNumber: String? = nil
    
    var body: some View {
        VStack {
            if selectedAccountNumber == nil {
                accountSummaryView()
                    .transition(.backwardScreenTransition)
                    .animation(.default)
            } else {
                accountDetailsView()
                    .transition(.forwardScreenTransition)
                    .animation(.default)
            }
        }
    }
    
    func select(accountNumber: String) {
        selectedAccountNumber = accountNumber
    }
        
    private func accountSummaryView() -> some View {
        let accountSummaryViewModel = AccountSummaryViewModel(
            accounts: Account.mockAccountList,
            reportSelectedAccountNumber: self.select(accountNumber:))
        
        let accountSummaryView =
            AccountSummaryView(accountSummaryViewModel: accountSummaryViewModel)
       
        return accountSummaryView
    }
    
    private func accountDetailsView() -> AnyView {
        guard let selectedAccount = Account.mockAccountList.first(where: {
            $0.accountNumber == selectedAccountNumber
        }) else {
            return AnyView(Text("Account for \(String(describing: selectedAccountNumber)) does not exist."))
        }
        
        let accountDetailsViewModel =
            AccountDetailsViewModel(account: selectedAccount,
                                    done: { self.selectedAccountNumber = nil })

        let accountDetailsView =
            AccountDetailsView(accountDetailsViewModel: accountDetailsViewModel)

        return AnyView(accountDetailsView)
    }

}

struct AccountManipulationCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        AccountDisplayCoordinator()
    }
}
