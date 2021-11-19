//
//  Green_Pass.swift
//  Green Pass
//
//  Created by Nikoloz Tatunashvili on 18.11.21.
//

import WidgetKit
import SwiftUI
import Intents

@main
struct Green_Pass: Widget {
    let kind: String = "Green_Pass"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            Green_PassEntryView(entry: entry)
        }
        .configurationDisplayName("Green Pass")
        .description("Your Green Pass QR Code")
        .supportedFamilies([.systemSmall])
    }
}

struct Green_Pass_Previews: PreviewProvider {
    static var previews: some View {
        Green_PassEntryView(entry: WidgetContent.content())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
