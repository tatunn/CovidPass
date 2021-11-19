//
//  UserDefaults+Extensions.swift
//  Nikora
//
//  Created by Nikoloz Tatunashvili on 12.04.21.
//

import Foundation

public extension UserDefaults {
    func save<T: Encodable>(newValue: T?, for key: String) {
        guard let newValue = newValue,
              let encoded = try? JSONEncoder.snakeCase.encode(newValue) else {
            self.removeObject(forKey: key)
            return
        }
        self.set(encoded, forKey: key)
    }

    func read<T: Decodable>(type: T.Type, for key: String) -> T? {
        guard let data = self.data(forKey: key) else { return nil }
        return try? JSONDecoder.snakeCase.decode(type, from: data)
    }
}

extension NSUbiquitousKeyValueStore {
    func save<T: Encodable>(newValue: T?, for key: String) {
        guard let newValue = newValue,
              let encoded = try? JSONEncoder.snakeCase.encode(newValue) else {
            self.removeObject(forKey: key)
            return
        }
        self.set(encoded, forKey: key)
    }

    func read<T: Decodable>(type: T.Type, for key: String) -> T? {
        guard let data = self.data(forKey: key) else { return nil }
        return try? JSONDecoder.snakeCase.decode(type, from: data)
    }
}
