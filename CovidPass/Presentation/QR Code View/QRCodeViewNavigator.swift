//
//  QRCodeViewNavigator.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 18.11.21.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit

class QRCodeViewNavigator: Navigator {
    private weak var viewController: UIViewController?

    public init(viewController: UIViewController) {
        self.viewController = viewController
    }

    enum Destination {
        case back
        case guide
        case web(link: String)
    }

    func navigate(to destination: Destination) {
        switch destination {
        case .back:
            viewController?.navigationController?.popViewController(animated: true)
        case .guide:
            openGuide()
        case let .web(link):
            web(path: link)
        }
    }

    private func openGuide() {
        UIApplication.shared.open(.init(string: "https://support.apple.com/en-us/HT207122")!)
    }

    private func web(path: String) {
        guard let link = URL(string: path) else { return }
        let vc = WebViewController.make(params: .init(url: link))
        viewController?.present(vc, animated: true)
    }
}

extension QRCodeViewController {
    static func make(params: QRCode.Params) -> QRCodeViewController {
        QRCodeViewController(params: params)
    }

    convenience private init(params: QRCode.Params) {
        self.init()
        viewModel = .init(params: params)
    }
}
