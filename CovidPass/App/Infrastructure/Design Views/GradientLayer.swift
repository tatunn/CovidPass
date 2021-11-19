//
//  GradientLayer.swift
//  Business
//
//  Created by Nikoloz Tatunashvili on 04.02.21.
//

import UIKit

open class GradientLayer: CAGradientLayer {
    var direction: GradientDirection? {
        didSet {
            startPoint = direction?.gradientType.x ?? .zero
            endPoint = direction?.gradientType.y ?? .zero
        }
    }
}
