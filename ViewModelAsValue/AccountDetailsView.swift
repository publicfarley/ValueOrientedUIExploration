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
            Text("\(accountDetailsViewModel.accountNumber)")
                .font(.largeTitle)
            
            Spacer()
            
            Text("\(accountDetailsViewModel.nickName)")
                .bold()
                .padding()
            
            Text("\(accountDetailsViewModel.accountType)").padding()

            Text("\(accountDetailsViewModel.balance)").padding()
            
            Button(action: {
                self.accountDetailsViewModel.done()
            }) {
                Text("Done")
            }
            
            Spacer()
        }
    }
}

//struct AccountDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountDetailsView()
//    }
//}
