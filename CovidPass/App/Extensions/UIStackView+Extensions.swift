//
//  UIStackView+Extensions.swift
//  Nikora
//
//  Created by Nikoloz Tatunashvili on 12.04.21.
//

import UIKit

public extension UIStackView {
    func removeAllArrangedSubViews() {
        arrangedSubviews.forEach {
            self.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
}
