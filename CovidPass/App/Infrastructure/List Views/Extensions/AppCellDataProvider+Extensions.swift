//
//  AppCellDataProvider+Extensions.swift
//  Business
//
//  Created by Nikoloz Tatunashvili on 04.02.21.
//

public extension Array where Element == AppCellDataProvider {
    func makeSection() -> AppSectionDataProvider {
        AppSectionDataProvider(dataProviders: self)
    }

    func makeList() -> AppListDataProvider {
        AppListDataProvider(sectionDataProvider: self.makeSection())
    }
}

public extension AppCellDataProvider {
    func makeSection() -> AppSectionDataProvider {
        AppSectionDataProvider(dataProviders: [self])
    }
}

public extension AppSectionDataProvider {
    func makeList() -> AppListDataProvider {
        AppListDataProvider(sectionDataProvider: self)
    }
}

public extension Array where Element == AppSectionDataProvider {
    func makeList() -> AppListDataProvider {
        AppListDataProvider(sectionDataProviders: self)
    }
}

public extension AppListDataProvider {
    convenience init(sectionDataProvider: AppSectionDataProvider) {
        self.init(sectionDataProviders: [sectionDataProvider])
    }
}
