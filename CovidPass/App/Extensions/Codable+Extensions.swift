//
//  Codable+Extensions.swift
//  Nikora
//
//  Created by Nikoloz Tatunashvili on 12.04.21.
//

import Foundation

public typealias Parameters = [String: Any]

extension Encodable {

    var convertedToData: Data? {
        try? JSONSerialization.data(withJSONObject: JSONParams, options: .prettyPrinted)
    }
    
    var JSONParams: Parameters {
        JSONParams()
    }

    func JSONParams(_ encoder: JSONEncoder = .snakeCase) -> Parameters {
        do {
            let data = try encoder.encode(self)
            let params = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return params as? [String: Any] ?? [:]
        } catch {
            return [:]
        }
    }
}

extension JSONDecoder {
    static let snakeCase: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
}

extension JSONEncoder {
    static let snakeCase: JSONEncoder = {
        let encoder = JSONEncoder()
        return encoder
    }()
}
