//
//  CredentialsViewModel.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 18.11.21.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation

class CredentialsViewModel {
    let params: Credentials.Params
    var output = Observable<Credentials.OutputAction?>(nil)
    var route = Observable<CredentialsViewNavigator.Destination?>(nil)
    private var repository: ClientProvider
    
    init(params: Credentials.Params) {
        self.params = params
        self.repository = ClientProvider()
    }

    func viewDidLoad() {
        output.value = .loader(start: false)
    }

    func submit(params: Credentials.AccountPostData) {
        guard let pin = params.pin?.pinValue,
              let phone = params.phone?.phoneValue,
              let year = params.year?.yearValue else {
            output.value = .error
            return
        }
        output.value = .loader(start: true)
        let params = ClientRequestParams(pin: pin, phone: phone, year: year)
        repository.registerClient(params: params) { [self] response in
            output.value = .loader(start: false)
            if let response = response, response.isSuccess == true {
                route.value = .otp(client: params)
                cache(params: params)
            } else {
                output.value = .error
            }
        }
    }

    private func cache(params: ClientRequestParams) {
        KeyStore.shared.setClient(params)
    }
}
