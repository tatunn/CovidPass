//
//  KeyStore.swift
//  Nikora
//
//  Created by Nikoloz Tatunashvili on 13.04.21.
//

import UIKit

extension KeyStore {
    
    private func save(_ value: ClientRequestParams, key: String) {
        keyStore.save(newValue: value, for: key)
        userDefaults?.save(newValue: value, for: key)
        sync()
    }

    public func setClient(_ value: ClientRequestParams) {
        save(value, key: clientLocalIdentifier)
    }

    public func tryFetchClient() -> ClientRequestParams? {
        keyStore.read(type: ClientRequestParams.self, for: clientLocalIdentifier) ??
        userDefaults?.read(type: ClientRequestParams.self, for: clientLocalIdentifier)
    }

    public func setEncryptId(_ value: String) {
        keyStore.set(value, forKey: encryptId)
        userDefaults?.set(value, forKey: encryptId)
        sync()
    }

    public func setForegroundColor(_ value: UIColor) {        
        keyStore.set(value.data, forKey: foregroundColor)
        userDefaults?.set(value.data, forKey: foregroundColor)
        sync()
    }

    public func setBackgroundColor(_ value: UIColor) {
        keyStore.set(value.data, forKey: backgroundColor)
        userDefaults?.set(value.data, forKey: backgroundColor)
        sync()
    }
}
