//
//  AppSupplementaryViewDataProvider.swift
//  Business
//
//  Created by Nikoloz Tatunashvili on 04.02.21.
//

import UIKit

public protocol AppSupplementaryViewDataProvider: AppCellDataProvider {
    var kind: AppSupplementaryKind { get }
}

public enum AppSupplementaryKind {
    case header, footer

    var value: String {
        switch self {
        case .header: return UICollectionView.elementKindSectionHeader
        case .footer: return UICollectionView.elementKindSectionFooter
        }
    }
}
