//
//  Api.swift
//  Nikora
//
//  Created by Nikoloz Tatunashvili on 15.04.21.
//

import Foundation

public protocol ServerInfo: AnyObject {
    static var scheme: String { get }
    static var host: String { get }
    static var path: String { get }
    static var baseUrl: URL { get }
}

extension ServerInfo {
    public static var baseUrl: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host   = host
        components.path   = path
        return components.url!
    }
}

class Api: ServerInfo {
    static var scheme: String {
        "https"
    }

    static var host: String {
        "covidpassreg.moh.gov.ge"
    }

    static var path: String {
        "/api/"
    }
}
