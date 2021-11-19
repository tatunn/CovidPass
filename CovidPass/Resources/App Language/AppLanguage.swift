//
//  AppLanguage.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 18.11.21.
//

import Foundation
import Rswift

enum AppLanguage: String {
    case english = "en"
    case georgian = "ka"

    static var current: AppLanguage {
        get { self.userSelected ?? .english }
        set { self.userSelected = newValue }
    }

    static var userSelected: AppLanguage? {
        get { UserDefaults.standard.string(forKey: #function)?.appLanguage }
        set { UserDefaults.standard.set(newValue?.rawValue, forKey: #function) }
    }

    var locale: Locale {
        switch self {
        case .english:
            return Locale(identifier: "en-US")
        case .georgian:
            return Locale(identifier: "ka-GE")
        }
    }

    var serverValue: String {
        switch self {
        case .english:
            return "en"
        case .georgian:
            return "ge"
        }
    }

    var otherLangFlag: String {
        switch self {
        case .english:
            return "🇬🇪"
        case .georgian:
            return "🇺🇸"
        }
    }

    fileprivate static func localString(for key: String) -> String {
        Bundle.main.path(forResource: current.rawValue, ofType: "lproj")?
            .bundle?.localizedString(forKey: key, value: nil, table: nil) ?? key
    }
}

fileprivate extension String {
    var appLanguage: AppLanguage? {
        AppLanguage(rawValue: self)
    }

    var bundle: Bundle? {
        Bundle(path: self)
    }
}

public extension String {
    var localized: String {
        AppLanguage.localString(for: self)
    }

    func localized(value: String?) -> String {
        localized.replacingOccurrences(of: "[VALUE]", with: value ?? "")
    }
}

public extension StringResourceType {
    var localized: String {
        self.bundle.path(forResource: AppLanguage.current.rawValue, ofType: "lproj")?
            .bundle?.localizedString(forKey: key, value: nil, table: nil) ?? key
    }

    func localized(value: String?) -> String {
        localized.replacingOccurrences(of: "[VALUE]", with: value ?? "")
    }
}
