//
//  AppTrippleColorGradientView.swift
//  Business
//
//  Created by Nikoloz Tatunashvili on 04.02.21.
//

import UIKit

public class AppTrippleColorGradientView: AppGradientView {
    @IBInspectable open var color3: UIColor = .clear {
        didSet {
            update()
        }
    }

    @IBInspectable open var location3: Double = 1 {
        didSet {
            update()
        }
    }

    @IBInspectable open var hasEqualTransition: Bool = true {
        didSet {
            update()
        }
    }

    open override var colors: [CGColor] {
        super.colors + [color3.cgColor]
    }

    open override var locations: [NSNumber] {
        hasEqualTransition ? [0, 0.5, 1] : super.locations + [NSNumber.init(value: location3)]
    }
}
