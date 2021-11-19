//
//  AppCircularButton.swift
//  Business
//
//  Created by Nikoloz Tatunashvili on 04.02.21.
//

import UIKit

public class AppCircularButton: UIButton, CircularView {
    public lazy var maskLayer: CAShapeLayer = { [unowned self] in
        let mask = makeMaskLayer(path: makeMaskLayerPath())
        self.layer.mask = mask
        return mask
    }()

    @IBInspectable open var hasSquareBorderRadius: Bool = false {
        didSet {
            update()
        }
    }

    @IBInspectable open var cornerRadius: CGFloat = 0 {
        didSet {
            update()
        }
    }

    @IBInspectable open var borderWidth: CGFloat = 0 {
        didSet {
            update()
        }
    }

    @IBInspectable open var borderColor: UIColor = .clear {
        didSet {
            update()
        }
    }

    public var normalizedCornerRadius: CGFloat {
        hasSquareBorderRadius ? min(bounds.height, bounds.width) * 0.5 : cornerRadius
    }

    public lazy var borderLayer: CAShapeLayer = {
        let borderLayer = CAShapeLayer()
        self.layer.addSublayer(borderLayer)
        return borderLayer
    }()

    open func update() {
        setupCornerRadius()
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        update()
    }
}
