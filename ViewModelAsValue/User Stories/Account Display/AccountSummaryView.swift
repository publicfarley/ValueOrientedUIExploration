//
//  AccountSummaryView.swift
//  ViewModelAsValue
//
//  Created by Farley Caesar on 2020-06-07.
//  Copyright © 2020 PureFunc. All rights reserved.
//

import SwiftUI

struct AccountSummaryView: View {
    
    let accountSummaryViewModel: AccountSummaryViewModel
    
    var body: some View {
        accountList
    }
}

// MARK: Body Components
private extension AccountSummaryView {
    var accountList: some View {
        List {
            ForEach(accountSummaryViewModel.accountNumbers, id: \.self) { item in
                Button(action: { self.accountSummaryViewModel.reportSelectedAccountNumber(item)
                }) {
                    Text("\(item)")
                }
            }
        }
    }
}

struct AccountSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        accountSummaryView()
    }
    
    static func accountSummaryView() -> some View {
        let accountSummaryViewModel = AccountSummaryViewModel(accounts: Account.mockAccountList, reportSelectedAccountNumber: { _ in })
        
        return AccountSummaryView(accountSummaryViewModel: accountSummaryViewModel)
    }
}
