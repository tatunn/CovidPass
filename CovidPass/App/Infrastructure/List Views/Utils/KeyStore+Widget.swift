//
//  KeyStore.swift
//  Nikora
//
//  Created by Nikoloz Tatunashvili on 13.04.21.
//

import UIKit
import SwiftUI

final class KeyStore {
    let clientLocalIdentifier = "CovidPassClient"
    let encryptId = "CovidPassClientEncryptId"
    let foregroundColor = "CovidPassForegroundColor"
    let backgroundColor = "CovidPassBackgroundColor"

    let userDefaults = UserDefaults(suiteName: "group.ge.gov.Covid-Pass")

    static let shared: KeyStore = .init()

    var keyStore: NSUbiquitousKeyValueStore

    private init() {
        keyStore = NSUbiquitousKeyValueStore.default
    }

    func sync() {
        keyStore.synchronize()
    }

    public func tryFetchEncryptId() -> String? {
        keyStore.string(forKey: encryptId) ??
            userDefaults?.string(forKey: encryptId)
    }

    public func tryFetchForeground() -> Color? {
        if let data = keyStore.data(forKey: foregroundColor) ??
            userDefaults?.data(forKey: foregroundColor),
            let color = UIColor.make(with: data) {
            return Color(color)
        }
        return nil
    }

    public func tryFetchBackground() -> Color? {
        if let data = keyStore.data(forKey: backgroundColor) ??
            userDefaults?.data(forKey: backgroundColor),
            let color = UIColor.make(with: data) {
            return Color(color)
        }
        return nil
    }

    public func tryFetchForegroundColor() -> UIColor? {
        if let data = keyStore.data(forKey: foregroundColor) ??
            userDefaults?.data(forKey: foregroundColor) {
            return UIColor.make(with: data)
        }
        return nil
    }

    public func tryFetchBackgroundColor() -> UIColor? {
        if let data = keyStore.data(forKey: backgroundColor) ??
            userDefaults?.data(forKey: backgroundColor) {
            return UIColor.make(with: data)
        }
        return nil
    }
}
