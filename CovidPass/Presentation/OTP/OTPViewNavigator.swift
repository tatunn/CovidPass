//
//  OTPViewNavigator.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 18.11.21.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit

class OTPViewNavigator: Navigator {
    private weak var viewController: UIViewController?

    public init(viewController: UIViewController) {
        self.viewController = viewController
    }

    enum Destination {
        case back
        case qrCodeView
    }

    func navigate(to destination: Destination) {
        switch destination {
        case .back:
            viewController?.navigationController?.popViewController(animated: true)
        case .qrCodeView:
            navigateQrView()
        }
    }

    private func navigateQrView() {
        let vc = QRCodeViewController.make(params: .init())
        vc.modalPresentationStyle = .fullScreen
        self.viewController?.present(vc, animated: true)
    }
}

extension OTPViewController {
    static func make(params: OTP.Params) -> OTPViewController {
        OTPViewController(params: params)
    }

    convenience private init(params: OTP.Params) {
        self.init()
        viewModel = .init(params: params)
    }
}
