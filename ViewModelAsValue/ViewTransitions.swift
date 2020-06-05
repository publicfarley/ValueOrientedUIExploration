//
//  ViewTransitions.swift
//  ViewModelAsValue
//
//  Created by Farley Caesar on 2020-06-06.
//  Copyright © 2020 PureFunc. All rights reserved.
//

import SwiftUI

extension AnyTransition {
    static var forwardScreenTransition: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing).combined(with: .opacity)
        let removal = AnyTransition.move(edge: .leading).combined(with: .opacity)

        return .asymmetric(insertion: insertion, removal: removal)
    }

    static var backwardScreenTransition: AnyTransition {
        let insertion = AnyTransition.move(edge: .leading).combined(with: .opacity)
        let removal = AnyTransition.move(edge: .trailing).combined(with: .opacity)
        
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
