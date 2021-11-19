//
//  AppTableViewCellable.swift
//  Business
//
//  Created by Nikoloz Tatunashvili on 04.02.21.
//

import UIKit

public extension UITableView {
    func register(types: AppCellRepresentable.Type...) {
        register(types: types)
    }

    func register(types: [AppCellRepresentable.Type]) {
        types.forEach {
            register($0.nib, forCellReuseIdentifier: $0.identifier)
        }
    }
}

public extension UITableView {
    func dequeueReusable(dataProvider: AppCellDataProvider, for indexPath: IndexPath) -> AppCellRepresentable {
        guard let cell = dequeueReusableCell(withIdentifier: dataProvider.identifier,
                                             for: indexPath) as? AppCellRepresentable else { fatalError() }
        return cell
    }

    func dequeueReusable(dataProvider: AppCellDataProvider) -> AppCellRepresentable {
        guard let cell = dequeueReusableCell(withIdentifier: dataProvider.identifier) as? AppCellRepresentable else {
            fatalError()
        }
        return cell
    }

    func dequeueReusable<T: AppCellRepresentable>(cell: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else { fatalError() }
        return cell
    }

    func dequeueReusable<T: AppCellRepresentable>(cell: T.Type) -> T? {
        dequeueReusableCell(withIdentifier: T.identifier) as? T
    }
}
