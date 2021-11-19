//
//  WebViewController.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 19.11.21.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    private lazy var navigator = WebViewNavigator(viewController: self)
    var viewModel: WebViewModel!

    @IBOutlet private weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        bind(to: viewModel)
        viewModel.viewDidLoad()
        
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
            presentationController.prefersGrabberVisible = true
        }
    }

    private func bind(to viewModel: WebViewModel) {
        viewModel.output.observe(on: self) { [weak self] action in
            self?.process(action)
        }

        viewModel.route.observe(on: self) { [weak self] destination in
            if let destination = destination {
                self?.navigator.navigate(to: destination)
            }
        }
    }

    private func process(_ action: Web.OutputAction?) {
        switch action {
        case .none: break
        case let .load(url):
            loadWebView(link: url)
        }
    }

    private func loadWebView(link: URL) {
        webView.load(.init(url: link))
    }

    @IBAction private func closeAction() {
        viewModel.route.value = .back
    }
}
