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
            switch selectedAccountNumber {
            case .some:
                accountDetailsView
                    .transition(.opacity)
                    .animation(.default)
            case .none:
                accountSummaryView
                    .transition(.opacity)
                    .animation(.default)
            }
        }
    }
    
    func select(accountNumber: String) {
        selectedAccountNumber = accountNumber
    }
}

// MARK: Body Components
private extension AccountDisplayCoordinator {
    var accountSummaryView: some View {
        let accountSummaryViewModel = AccountSummaryViewModel(
            accounts: Account.mockAccountList,
            reportSelectedAccountNumber: self.select(accountNumber:))
        
        let accountSummaryView =
            AccountSummaryView(accountSummaryViewModel: accountSummaryViewModel)
       
        return accountSummaryView
    }
    
    var accountDetailsView: AnyView {
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
