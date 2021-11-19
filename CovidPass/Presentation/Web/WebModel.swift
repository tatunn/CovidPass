//
//  WebModel.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 19.11.21.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation

enum Web {
    struct Params {
        let url: URL
    }

    enum OutputAction {
        case load(url: URL)
    }
}
