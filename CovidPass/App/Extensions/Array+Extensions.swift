//
//  Array+Extensions.swift
//  Nikora
//
//  Created by Nikoloz Tatunashvili on 12.04.21.
//

import Foundation

extension Array {
    func value(for index: Int) -> Element? {
        if self.indices.contains(index) {
            return self[index]
        }
        return nil
    }
}
