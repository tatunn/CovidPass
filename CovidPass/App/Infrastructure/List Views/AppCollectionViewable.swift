//
//  AppCollectionViewable.swift
//  Business
//
//  Created by Nikoloz Tatunashvili on 04.02.21.
//

import UIKit

public protocol AppCollectionViewable: UICollectionViewDataSource, UICollectionViewDelegate {
    var dataProvider: AppListDataProvider? { get set }
}

public extension AppCollectionViewable {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataProvider?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataProvider?[section].count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dataProvider = dataProvider?[indexPath],
              let cell = collectionView.dequeueReusable(dataProvider: dataProvider,
                                                        for: indexPath) as? UICollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let dataProvider = dataProvider?[indexPath] else { return }
        (cell as? AppCellRepresentable)?.setup(with: dataProvider)
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionDataProvider = dataProvider?.sectionDataProvider(at: indexPath.section) else {
            fatalError("section not found at index \(indexPath.section)")
        }

        let reusableDataProvider = kind == AppSupplementaryKind.header.value ?
            sectionDataProvider.header : sectionDataProvider.footer

        if reusableDataProvider == nil { return UICollectionReusableView() }

        guard let supplementaryViewDataProvider = reusableDataProvider as? AppSupplementaryViewDataProvider else {
            fatalError("header or footer dataProvider is not AppSupplementaryViewDataProvider")
        }

        let cell = collectionView.dequeueReusableSupplementary(dataProvider: supplementaryViewDataProvider,
                                                               for: indexPath)
        cell.setup(with: supplementaryViewDataProvider)
        return cell as? UICollectionReusableView ?? UICollectionReusableView()
    }
}
