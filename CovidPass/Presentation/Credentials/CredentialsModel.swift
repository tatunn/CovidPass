//
//  CredentialsModel.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 18.11.21.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation

enum Credentials {
    struct Params {
    }

    enum OutputAction {
        case loader(start: Bool)
        case error
    }

    struct AccountPostData {
        let pin: String?
        let year: String?
        let phone: String?
    }
}
