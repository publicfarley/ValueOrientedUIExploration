//
//  KeyboardAwareViewModifier.swift
//  ViewModelAsValue
//
//  Created by Farley Caesar on 2020-06-08.
//  Copyright © 2020 PureFunc. All rights reserved.
//

// From: https://swiftwithmajid.com/2019/11/27/combine-and-swiftui-views/
import SwiftUI
import Combine

struct KeyboardAwareViewModifier: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0

    private var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
                .map { $0.height },

            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in CGFloat(0) }
        ).eraseToAnyPublisher()
    }

    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight + keyboardHeight*0.25)
            .onReceive(keyboardHeightPublisher) { self.keyboardHeight = $0 }
    }
}

extension View {
    func keyboardAwarePadding() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAwareViewModifier())
    }
}
