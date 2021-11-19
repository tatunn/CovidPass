//
//  ClientResponse.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 18.11.21.
//

import Foundation

struct ClientResponse: Codable {
    let isSuccess: Bool?
    let message: String?
    let result: Result?
    
    struct Result: Codable {
        let encryptId: String?
    }
}
