//
//  Account.swift
//  ViewModelAsValue
//
//  Created by Farley Caesar on 2020-06-07.
//  Copyright © 2020 PureFunc. All rights reserved.
//

import Foundation

struct Account {
    enum AccountType {
        case chequing
        case saving
    }
    
    let accountNumber: String
    let type: AccountType
    let nickName: String
    let balance: Double
}

extension Account {
    static var mockAccountList: [Account] {
        [
    Account(accountNumber: "12237889",
            type: .chequing,
            nickName: "My Chequing Account",
            balance: 454255.73),
    Account(accountNumber: "12345677",
            type: .saving,
            nickName: "Saving Account",
            balance: 100.00)
        ]
    }
}

