//
//  WebViewNavigator.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 19.11.21.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit

class WebViewNavigator: Navigator {
    private weak var viewController: UIViewController?

    public init(viewController: UIViewController) {
        self.viewController = viewController
    }

    enum Destination {
        case back
    }

    func navigate(to destination: Destination) {
        switch destination {
        case .back:
            viewController?.dismiss(animated: true, completion: nil)
        }
    }
}

extension WebViewController {
    static func make(params: Web.Params) -> WebViewController {
        WebViewController(params: params)
    }

    convenience private init(params: Web.Params) {
        self.init()
        viewModel = .init(params: params)
    }
}
