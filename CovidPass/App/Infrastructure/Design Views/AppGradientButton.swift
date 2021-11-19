//
//  AppGradientButton.swift
//  Business
//
//  Created by Nikoloz Tatunashvili on 04.02.21.
//

import UIKit
public class AppGradientButton: AppCircularButton, GradientView {
    override open class var layerClass: Swift.AnyClass {
        GradientLayer.self
    }

    @IBInspectable open var color1: UIColor = .clear {
        didSet {
            update()
        }
    }

    @IBInspectable open var color2: UIColor = .clear {
        didSet {
            update()
        }
    }

    @IBInspectable open var location1: Double = 0 {
        didSet {
            update()
        }
    }

    @IBInspectable open var location2: Double = 1 {
        didSet {
            update()
        }
    }

    @IBInspectable open var directionString: String = GradientDirection.leftRight.rawValue {
        didSet {
            update()
        }
    }

    open var colors: [CGColor] {
        [color1, color2].map { $0.cgColor }
    }

    open var locations: [NSNumber] {
        [location1, location2].map { NSNumber.init(value: $0) }
    }

    open override func update() {
        super.update()

        setupGradient()
    }
}
