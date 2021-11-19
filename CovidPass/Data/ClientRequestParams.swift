//
//  ClientRequestParams.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 18.11.21.
//

import Foundation

struct ClientRequestParams: Codable {
    var userName: String?
    var phoneNumber: String?
    var dateOfBirth: String?
    var language: String?
    var smsCode: String?
    var firstName: String?
    var lastName: String?
    var docNumber: String?
    var citizenship = true
    
    init(pin: String, phone: String, year: String) {
        self.userName = pin
        self.phoneNumber = phone
        self.dateOfBirth = "\(year)-01-31T21:00:00Z"
        self.language = AppLanguage.current.serverValue
    }

    mutating func setOtp(code: String) {
        self.smsCode = code
        self.firstName = ""
        self.lastName = ""
        self.docNumber = ""
    }
}
