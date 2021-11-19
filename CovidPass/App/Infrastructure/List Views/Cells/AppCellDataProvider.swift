//
//  AppCellDataProvider.swift
//  Business
//
//  Created by Nikoloz Tatunashvili on 04.02.21.
//

import UIKit

public protocol Identifierable {
    var identifier: String { get }
}

public protocol AppCellDataProvider: AnyObject, Identifierable {
}

public func == (left: Identifierable, right: Identifierable) -> Bool {
    left.identifier == right.identifier
}

public protocol AppCellRepresentable: AnyObject {
    static var nib: UINib { get }
    static var identifier: String { get }
    func setup(with item: AppCellDataProvider)
}

public extension AppCellRepresentable where Self: UITableViewCell {
    static var identifier: String { className }
    static var nib: UINib { UINib(nibName: className, bundle: .main) }
}

public protocol StaticHeightDataProvider: AppCellDataProvider {
    var height: CGFloat { get set }
    var isHeightSet: Bool { get }
    func calculate() -> CGFloat
}

public extension StaticHeightDataProvider {
    var isHeightSet: Bool { height > 0 }

    func calculate() -> CGFloat {
        if !isHeightSet {
            height = UITableView.automaticDimension
        }
        return height
    }
}

public protocol ExpandableDataProvider: StaticHeightDataProvider {
    var expandedHeight: CGFloat? { get set }
    var collapsedHeight: CGFloat? { get set }
    var state: AppTableViewCellState { get set }
}

public extension ExpandableDataProvider {
    var isExpanedHeightSet: Bool {
        expandedHeight != nil
    }

    var isCollapsedHeightSet: Bool {
        collapsedHeight != nil
    }

    var height: CGFloat {
        state == .expanded ? (expandedHeight ?? 0) : (collapsedHeight ?? 0)
    }
}

public enum AppTableViewCellState {
    case expanded, collapsed
}
