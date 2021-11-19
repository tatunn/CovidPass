//
//  QRCodeViewModel.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 18.11.21.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation

class QRCodeViewModel {
    private let prefix = "https://covidpass.moh.gov.ge/"
    let params: QRCode.Params
    var output = Observable<QRCode.OutputAction?>(nil)
    var route = Observable<QRCodeViewNavigator.Destination?>(nil)
    private lazy var store = KeyStore.shared

    init(params: QRCode.Params) {
       self.params = params
    }

    func viewDidLoad() {
        updateData()
    }

    func updateData() {
        output.value = .qrCode(id: prefix + (store.tryFetchEncryptId() ?? "testQRCode"))
    }

    func openWebView() {
        guard let id = store.tryFetchEncryptId() else { return }
        route.value = .web(link: prefix + id)
    }
}
