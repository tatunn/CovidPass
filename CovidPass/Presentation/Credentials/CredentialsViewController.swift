//
//  CredentialsViewController.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 18.11.21.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit

class CredentialsViewController: UIViewController {

    private lazy var navigator = CredentialsViewNavigator(viewController: self)
    var viewModel: CredentialsViewModel!

    @IBOutlet private weak var pinTextField: UITextField!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var yearTextField: UITextField!
    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private weak var languageButton: UIButton!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    @IBOutlet private weak var scrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind(to: viewModel)
        viewModel.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        pinTextField.placeholder = R.string.localizable.pinInputPlaceholder.localized
        yearTextField.placeholder = R.string.localizable.yearInputPlaceholder.localized
        phoneTextField.placeholder = R.string.localizable.phoneInputPlaceholder.localized
        submitButton.setTitle(R.string.localizable.continueButton.localized, for: .normal)
        languageButton.setTitle(AppLanguage.current.otherLangFlag, for: .normal)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc private func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        let bottomSpace = keyboardViewEndFrame.height + view.safeAreaInsets.bottom
        let contentHeight = scrollview.contentSize.height
        let diff = scrollview.bounds.height - contentHeight - bottomSpace
        scrollview.contentInset.bottom = diff > 0 ? .zero : bottomSpace
    }

    private func bind(to viewModel: CredentialsViewModel) {
        viewModel.output.observe(on: self) { [weak self] action in
            self?.process(action)
        }

        viewModel.route.observe(on: self) { [weak self] destination in
            if let destination = destination {
                self?.navigator.navigate(to: destination)
            }
        }
    }

    private func process(_ action: Credentials.OutputAction?) {
        switch action {
        case .none: break
        case .error:
            showAlert()
        case let .loader(start):
            loader(start: start)
        }
    }

    @IBAction private func submitAction() {
        let params = Credentials.AccountPostData(pin: pinTextField.text, year: yearTextField.text, phone: phoneTextField.text)
        viewModel.submit(params: params)
    }

    @IBAction private func languageAction() {
        let new: AppLanguage = AppLanguage.current == .georgian ? .english : .georgian
        AppLanguage.current = new
        setupUI()
    }
    
    private func showAlert() {
        loader(start: false)
        presentError(title: R.string.localizable.alertTitle.localized,
                     message: R.string.localizable.alertMessage.localized)
    }

    private func loader(start: Bool) {
        submitButton.isUserInteractionEnabled = !start
        submitButton.isHidden = start
        start ? indicator.startAnimating() : indicator.stopAnimating()
        indicator.isHidden = !start
    }
}
