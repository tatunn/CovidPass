//
//  WebViewModel.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 19.11.21.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation

class WebViewModel {
    let params: Web.Params
    var output = Observable<Web.OutputAction?>(nil)
    var route = Observable<WebViewNavigator.Destination?>(nil)

    init(params: Web.Params) {
       self.params = params
    }

    func viewDidLoad() {
        output.value = .load(url: params.url)
    }
}
