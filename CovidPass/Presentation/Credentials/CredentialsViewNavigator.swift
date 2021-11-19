//
//  CredentialsViewNavigator.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 18.11.21.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit

class CredentialsViewNavigator: Navigator {
    private weak var viewController: UIViewController?

    public init(viewController: UIViewController) {
        self.viewController = viewController
    }

    enum Destination {
        case back
        case otp(client: ClientRequestParams)
    }

    func navigate(to destination: Destination) {
        switch destination {
        case .back:
            viewController?.navigationController?.popViewController(animated: true)
        case let .otp(client):
            navigateToOTP(client: client)
        }
    }

    private func navigateToOTP(client: ClientRequestParams) {
        let vc = OTPViewController.make(params: .init(client: client))
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        viewController?.present(vc, animated: true)
    }
}

extension CredentialsViewController {
    static func make(params: Credentials.Params) -> CredentialsViewController {
        CredentialsViewController(params: params)
    }

    convenience private init(params: Credentials.Params) {
        self.init()
        viewModel = .init(params: params)
    }
}
