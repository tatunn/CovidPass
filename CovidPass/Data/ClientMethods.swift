//
//  ClientMethods.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 18.11.21.
//

import Foundation

enum ClientMethods: Methodable {
    case client(data: ClientRequestParams)
    case otp(data: ClientRequestParams)
    
    var path: String {
        "account"
    }
    
    private var httpBody: Data? {
        switch self {
        case let .otp(data): return data.convertedToData
        case let .client(data): return data.convertedToData
        }
    }

    private var httpMethod: String? {
        switch self {
        case .client: return "POST"
        case .otp: return "PUT"
        }
    }
    
    var request: URLRequest {
        var request = URLRequest(url: URL(string: Api.baseUrl.absoluteString + path)!)
        request.httpMethod = httpMethod
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
