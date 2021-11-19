//
//  CollectionView.swift
//  Business
//
//  Created by Nikoloz Tatunashvili on 04.02.21.
//

import UIKit

public extension UICollectionView {
    func register(types: AppCellRepresentable.Type...) {
        register(types: types)
    }

    func register(types: [AppCellRepresentable.Type]) {
        types.forEach {
            register($0.nib, forCellWithReuseIdentifier: $0.identifier)
        }
    }
}

public extension UICollectionView {
    func dequeueReusable(dataProvider: AppCellDataProvider?, for indexPath: IndexPath) -> AppCellRepresentable? {
        guard let dataProvider = dataProvider else { return nil }
        return dequeueReusableCell(withReuseIdentifier: dataProvider.identifier,
                                   for: indexPath) as? AppCellRepresentable
    }

    func dequeueReusable<T: AppCellRepresentable>(cell: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cell.identifier,
                                             for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }

    func dequeueReusableSupplementary(dataProvider: AppSupplementaryViewDataProvider,
                                      for indexPath: IndexPath) -> AppCellRepresentable {
        guard let cell = dequeueReusableSupplementaryView(ofKind: dataProvider.kind.value,
                                                withReuseIdentifier: dataProvider.identifier,
                                                for: indexPath) as? AppCellRepresentable else { fatalError() }
        return cell
    }

    func dequeueReusableSupplementary<T: AppCellRepresentable>(view: T.Type, kind: AppSupplementaryKind,
                                                               for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind.value, withReuseIdentifier: T.identifier,
                                                   for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }
}
