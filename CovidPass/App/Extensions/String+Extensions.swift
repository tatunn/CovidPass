//
//  String+Extensions.swift
//  Nikora
//
//  Created by Nikoloz Tatunashvili on 12.04.21.
//

import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }

    var isNotEmpty: Bool {
        return !isEmpty
    }

    func toImage() -> UIImage? {
        guard let imageData = Data(base64Encoded: self,
                                   options: Data.Base64DecodingOptions.ignoreUnknownCharacters) else { return nil }
        return UIImage(data: imageData)
    }

    var notEmptyValue: String? {
        isEmpty ? nil : self
    }

    var pinValue: String? {
        let value = String(self.prefix(11))
        return (value.count == 11 && value.intValue != nil) ? value : nil
    }

    var phoneValue: String? {
        let value = String(self.prefix(9))
        return (value.count == 9 && value.intValue != nil) ? value : nil
    }

    var yearValue: String? {
        let currentYear = Calendar.current.component(.year, from: Date())
        let value = String(self.prefix(4))
        guard let year = value.intValue,
              year <= currentYear && year > (currentYear - 120) else {
            return nil
        }
        return value
    }

    var otpValue: String? {
        intValue != nil ? self : nil
    }

    var intValue: Int? {
        Int(self)
    }
}
