//
//  AppTableViewController.swift
//  Business
//
//  Created by Nikoloz Tatunashvili on 04.02.21.
//

import UIKit

public protocol AppTableViewable: AnyObject {
    var dataProvider: AppListDataProvider? { get set }
}

extension AppTableViewable where Self: UITableViewController {
    func headerFooterView(_ tableView: UITableView, for dataProvider: AppCellDataProvider?) -> UIView? {
        guard let dataProvider = dataProvider else { return nil }
        let cell = tableView.dequeueReusable(dataProvider: dataProvider)
        cell.setup(with: dataProvider)
        return (cell as? UITableViewCell)
    }

    func height(for dataProvider: AppCellDataProvider?) -> CGFloat {
        guard let item = dataProvider else { return .zero }
        if let staticHeight = item as? StaticHeightDataProvider {
            if staticHeight.isHeightSet {
                return staticHeight.height
            } else {
                return staticHeight.calculate()
            }
        }
        return UITableView.automaticDimension
    }
}

class AppTableViewController: UITableViewController, AppTableViewable {
    var action: Observable<AppTableView.Action?> = .init(.none)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedSectionHeaderHeight = 20
        tableView.estimatedSectionFooterHeight = 20
        tableView.backgroundColor = .clear
    }

    var dataProvider: AppListDataProvider?

    override func numberOfSections(in tableView: UITableView) -> Int {
        dataProvider?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataProvider?[section].count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataProvider = dataProvider?[indexPath],
              let cell = tableView.dequeueReusable(dataProvider: dataProvider,
                                                   for: indexPath) as? UITableViewCell else {
            return UITableViewCell()
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        height(for: dataProvider?[indexPath])
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        height(for: dataProvider?[section].header)
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        height(for: dataProvider?[section].footer)
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        guard let dataProvider = dataProvider?[indexPath] else { return }
        (cell as? AppCellRepresentable)?.setup(with: dataProvider)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerFooterView(tableView, for: dataProvider?.sectionDataProvider(at: section).header)
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        headerFooterView(tableView, for: dataProvider?.sectionDataProvider(at: section).footer)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        action.value = .didSelectRow(indexPath: indexPath)
    }
}
