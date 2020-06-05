//
//  AccountDetailsViewModel.swift
//  ViewModelAsValue
//
//  Created by Farley Caesar on 2020-06-07.
//  Copyright © 2020 PureFunc. All rights reserved.
//

import Foundation

struct AccountDetailsViewModel {
    let account: Account
    let done: () -> Void
    
    var accountNumber: String {
        account.accountNumber
    }
    
    var accountType: String {
        switch account.type {
        case .chequing: return "Chequing"
        case .saving: return "Saving"
        }
    }
    
    var nickName: String {
        account.nickName
    }
    
    var balance: String {
        "$\(account.balance)"
    }
}
