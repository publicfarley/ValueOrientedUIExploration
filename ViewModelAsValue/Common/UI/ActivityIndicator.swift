//
//  ActivityIndicator.swift
//  ViewModelAsValue
//
//  Created by Farley Caesar on 2020-06-09.
//  Copyright © 2020 PureFunc. All rights reserved.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        return uiView.startAnimating()
    }
}
