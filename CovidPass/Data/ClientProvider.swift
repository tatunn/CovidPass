//
//  ClientProvider.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 18.11.21.
//

import Foundation

class ClientProvider {
    func registerClient(params: ClientRequestParams, completion: @escaping (ClientResponse?) -> Void) {
        ClientMethods.client(data: params).perform { (result: Result<ClientResponse, Error>) in
            switch result {
            case let .success(value):
                completion(value)
            case .failure:
                completion(nil)
            }
        }
    }

    func confirmClient(params: ClientRequestParams, completion: @escaping (ClientResponse?) -> Void) {
        ClientMethods.otp(data: params).perform { (result: Result<ClientResponse, Error>) in
            switch result {
            case let .success(value):
                completion(value)
            case .failure:
                completion(nil)
            }
        }
    }
}
