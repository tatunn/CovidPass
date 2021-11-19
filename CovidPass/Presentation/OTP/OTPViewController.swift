//
//  OTPViewController.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 18.11.21.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit

class OTPViewController: UIViewController {

    private lazy var navigator = OTPViewNavigator(viewController: self)
    var viewModel: OTPViewModel!

    @IBOutlet private weak var otpTextField: UITextField!
    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        bind(to: viewModel)
        viewModel.viewDidLoad()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        otpTextField.becomeFirstResponder()
    }

    private func setupUI() {
        otpTextField.placeholder = R.string.localizable.smsInputPlaceholder.localized
        submitButton.setTitle(R.string.localizable.continueButton.localized, for: .normal)
    }

    private func bind(to viewModel: OTPViewModel) {
        viewModel.output.observe(on: self) { [weak self] action in
            self?.process(action)
        }

        viewModel.route.observe(on: self) { [weak self] destination in
            if let destination = destination {
                self?.navigator.navigate(to: destination)
            }
        }
    }

    private func process(_ action: OTP.OutputAction?) {
        switch action {
        case .none: break
        case let .loader(start):
            loader(start: start)
        case .error:
            showAlert()
        }
    }

    @IBAction private func submitAction() {
        viewModel.submit(otp: otpTextField.text)
    }

    private func showAlert() {
        loader(start: false)
        let alert = UIAlertController(title: R.string.localizable.otpCodeAlertTitle.localized,
                                      message: R.string.localizable.otpCodeAlertMessage.localized,
                                      preferredStyle: .alert)
        alert.addAction(.init(title: R.string.localizable.alertOk.localized,
                              style: .default, handler: { [weak self] _ in
            self?.viewModel.tryResentCode()
        }))
        self.present(alert, animated: true)
    }

    private func loader(start: Bool) {
        submitButton.isUserInteractionEnabled = !start
        submitButton.isHidden = start
        start ? indicator.startAnimating() : indicator.stopAnimating()
        indicator.isHidden = !start
    }
}
