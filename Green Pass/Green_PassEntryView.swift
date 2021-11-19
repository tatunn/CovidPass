//
//  Green_PassEntryView.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 18.11.21.
//

import WidgetKit
import SwiftUI
import Intents

struct Green_PassEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            VStack {
                Spacer()
                Image(uiImage: UIImage(
                        barcode: entry.cardNumber,
                        using: KeyStore.shared.tryFetchForegroundColor() ?? .black
                        )!
                    )
                .resizable()
                Spacer()
            }
            .padding(.leading, 16)
            .padding(.top, 6)
            .padding(.trailing, 14)
            .padding(.bottom, 10)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .foregroundColor(.white)
        .background(KeyStore.shared.tryFetchBackground() ?? .white)
    }
}

struct Green_PassEntryView_Previews: PreviewProvider {
    static func makeEntry() -> WidgetContent {
        WidgetContent.content()
    }
    
    static var previews: some View {
        Green_PassEntryView(entry: makeEntry())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
