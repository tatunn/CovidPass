//
//  Provider.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 18.11.21.
//

import WidgetKit
import SwiftUI
import Intents

private let prefix = "https://covidpass.moh.gov.ge/"

struct WidgetContent: TimelineEntry {
    var date = Date()
    let cardNumber: String
}

extension WidgetContent {
    static func content() -> WidgetContent {
        WidgetContent(cardNumber: prefix + (KeyStore.shared.tryFetchEncryptId() ?? ""))
    }
}


struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> WidgetContent {
        WidgetContent.content()
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (WidgetContent) -> ()) {
        completion(WidgetContent.content())
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<WidgetContent>) -> ()) {
        let timeline = Timeline(entries: [WidgetContent.content()], policy: .atEnd)
        completion(timeline)
    }
}
