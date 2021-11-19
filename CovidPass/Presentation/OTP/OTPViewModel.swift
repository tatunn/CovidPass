//
//  OTPViewModel.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 18.11.21.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation

class OTPViewModel {
    let params: OTP.Params
    var output = Observable<OTP.OutputAction?>(nil)
    var route = Observable<OTPViewNavigator.Destination?>(nil)
    private var repository: ClientProvider
    private var lastSentTime = Date()
    
    init(params: OTP.Params) {
        self.params = params
        self.repository = ClientProvider()
    }

    func viewDidLoad() {
        output.value = .loader(start: false)
        lastSentTime = Date()
    }

    func submit(otp: String?) {
        guard let code = otp?.otpValue else {
            output.value = .error
            return
        }
        output.value = .loader(start: true)
        var params = params.client
        params.setOtp(code: code)
        repository.confirmClient(params: params) { [self] response in
            output.value = .loader(start: false)
            if let encriptedId = response?.result?.encryptId {
                KeyStore.shared.setEncryptId(encriptedId)
                route.value = .qrCodeView
            } else {
                output.value = .error
            }
        }
    }

    func tryResentCode() {
        if Date().timeIntervalSince(lastSentTime) < 60 {
            return
        }
        repository.registerClient(params: params.client) { _ in }
    }
}
