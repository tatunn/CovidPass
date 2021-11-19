//
//  OTPModel.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 18.11.21.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation

enum OTP {
    struct Params {
        let client: ClientRequestParams
    }

    enum OutputAction {
        case loader(start: Bool)
        case error
    }
}
