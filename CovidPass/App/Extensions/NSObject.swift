//
//  NSObject.swift
//  Nikora
//
//  Created by Nikoloz Tatunashvili on 12.04.21.
//

import Foundation

typealias VoidFunction = () -> Void

extension NSObject {
    public var className: String {
        return String(describing: type(of: self))
    }

    public class var className: String {
        return String(describing: self)
    }
}
