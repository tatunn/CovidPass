//
//  UIView+Extensions.swift
//  Nikora
//
//  Created by Nikoloz Tatunashvili on 12.04.21.
//

import UIKit

public struct EdgeConstraint {
    public let top: NSLayoutConstraint
    public let bottom: NSLayoutConstraint
    public let leading: NSLayoutConstraint
    public let traling: NSLayoutConstraint
}

public extension UIView {

    @discardableResult
    func placeEdgeToEdge(in parentView: UIView, insets: UIEdgeInsets = .zero) -> EdgeConstraint {
        let top = topAnchor.constraint(equalTo: parentView.topAnchor, constant: insets.top)
        let bottom = bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: insets.bottom)
        let left = leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: insets.left)
        let right = trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: insets.right)

        NSLayoutConstraint.activate([top, bottom, left, right])

        return EdgeConstraint(top: top, bottom: bottom, leading: left, traling: right)
    }

    @discardableResult
    func pinSafely(in parentView: UIView, insets: UIEdgeInsets = .zero) -> EdgeConstraint {
        let top = topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor, constant: insets.top)
        let bottom = bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor,
                                             constant: insets.bottom)
        let left = leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor,
                                            constant: insets.left)
        let right = trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor,
                                              constant: insets.right)

        NSLayoutConstraint.activate([top, bottom, left, right])

        return EdgeConstraint(top: top, bottom: bottom, leading: left, traling: right)
    }

    func removeAllSubViews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
