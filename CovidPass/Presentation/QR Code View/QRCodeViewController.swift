//
//  QRCodeViewController.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 18.11.21.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController {
    private lazy var navigator = QRCodeViewNavigator(viewController: self)
    var viewModel: QRCodeViewModel!
    @IBOutlet weak var qrImageView: UIImageView!
    @IBOutlet weak var qrTextLabel: UILabel!
    @IBOutlet weak var qrBackgroundView: UIView!
    @IBOutlet weak var bgColorLabel: UILabel!
    @IBOutlet weak var fgColorLabel: UILabel!
    @IBOutlet weak var guideButton: UIButton!
    private let colorPickerVC = ColorPickerViewController()

    private var foregroundColor: UIColor = .black
    private var backgroundColor: UIColor = .white
    private var pickerState: ColorPickerState = .foreground
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foregroundColor = KeyStore.shared.tryFetchForegroundColor() ?? .black
        backgroundColor = KeyStore.shared.tryFetchBackgroundColor() ?? .white
        bind(to: viewModel)
        viewModel.viewDidLoad()
        colorPickerVC.delegate = self
        setupUI()
    }

    private func setupUI() {
        bgColorLabel.text = R.string.localizable.backgroundColor.localized
        fgColorLabel.text = R.string.localizable.foregroundColor.localized
        guideButton.setTitle(R.string.localizable.widgetGuide.localized, for: .normal)
    }

    private func bind(to viewModel: QRCodeViewModel) {
        viewModel.output.observe(on: self) { [weak self] action in
            self?.process(action)
        }

        viewModel.route.observe(on: self) { [weak self] destination in
            if let destination = destination {
                self?.navigator.navigate(to: destination)
            }
        }
    }

    private func process(_ action: QRCode.OutputAction?) {
        switch action {
        case .none: break
        case let .qrCode(code):
            qrQode(code: code)
        }
    }

    @IBAction private func widgetGuide() {
        viewModel.route.value = .guide
    }

    @IBAction private func openStatusDetailsAction() {
        viewModel.openWebView()
    }
    
    @IBAction private func foregroundColorAction() {
        pickerState = .foreground
        colorPickerVC.selectedColor = foregroundColor
        present(colorPickerVC, animated: true)
    }

    @IBAction private func backgroundColorAction() {
        pickerState = .background
        colorPickerVC.selectedColor = backgroundColor
        present(colorPickerVC, animated: true)
    }

    private func qrQode(code: String) {
        qrImageView.image = UIImage(barcode: code, using: foregroundColor)
        qrTextLabel.text = code
        qrBackgroundView.backgroundColor = backgroundColor
    }

    private func changeColors(color: UIColor) {
        switch pickerState {
        case .background:
            self.backgroundColor = color
        case .foreground:
            self.foregroundColor = color
        }
        viewModel.updateData()
        saveColors()
    }

    private func saveColors() {
        KeyStore.shared.setForegroundColor(foregroundColor)
        KeyStore.shared.setBackgroundColor(backgroundColor)
    }
}

extension QRCodeViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        changeColors(color: color)
    }

    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}

extension QRCodeViewController {
    enum ColorPickerState {
        case background
        case foreground
    }
}
