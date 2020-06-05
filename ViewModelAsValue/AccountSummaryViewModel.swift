//
//  AccountSummaryViewModel.swift
//  ViewModelAsValue
//
//  Created by Farley Caesar on 2020-06-07.
//  Copyright © 2020 PureFunc. All rights reserved.
//

import Foundation

struct AccountSummaryViewModel {
    let accounts: [Account]
    
    let reportSelectedAccountNumber: (String) -> Void
    
    var accountNumbers: [String] {
        accounts.map { $0.accountNumber }
    }
}
