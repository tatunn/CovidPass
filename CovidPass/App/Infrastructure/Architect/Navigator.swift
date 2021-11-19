//
//  Navigator.swift
//  Business
//
//  Created by Nikoloz Tatunashvili on 04.02.21.
//

import Foundation

public protocol Navigator {
    associatedtype Destination

    func navigate(to destination: Destination)
}
