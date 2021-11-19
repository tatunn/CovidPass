//
//  SplashScreenViewController.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 18.11.21.
//

import UIKit

class SplashScreenViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if KeyStore.shared.tryFetchEncryptId() != nil {
            navigateQrView()
        } else {
            navigateRegisterView()
        }
    }

    private func navigateRegisterView() {
        let vc = CredentialsViewController.make(params: .init())
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }

    private func navigateQrView() {
        let vc = QRCodeViewController.make(params: .init())
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
}
