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

//struct AccountSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountSummaryView()
//    }
//}
