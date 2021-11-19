//
//  UIImage+Extensions.swift
//  Nikora
//
//  Created by Nikoloz Tatunashvili on 14.04.21.
//

import UIKit

extension UIImage {
    convenience init?(barcode string: String) {
        if let outputCIImage = CIImage.make(barcode: string) {
            let context = CIContext()
            guard let cgImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else { return nil }
            self.init(cgImage: cgImage)
            return
        }
        return nil
    }

    convenience init?(barcode string: String, using color: UIColor) {
        if let outputCIImage = CIImage.make(barcode: string)?.tinted(using: color) {
            let context = CIContext()
            guard let cgImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else { return nil }
            self.init(cgImage: cgImage)
            return
        }
        return nil
    }
}

extension CIImage {
    static func make(barcode string: String) -> CIImage? {
        let data = string.data(using: .ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("H", forKey: "inputCorrectionLevel")
            let transform = CGAffineTransform(scaleX: 6, y: 6)
            return filter.outputImage?.transformed(by: transform)
        }
        return nil
    }
}

extension CIImage {

    var transparent: CIImage? {
        return inverted?.blackTransparent
    }

    var inverted: CIImage? {
        guard let invertedColorFilter = CIFilter(name: "CIColorInvert") else { return nil }

        invertedColorFilter.setValue(self, forKey: "inputImage")
        return invertedColorFilter.outputImage
    }

    var blackTransparent: CIImage? {
        guard let blackTransparentFilter = CIFilter(name: "CIMaskToAlpha") else { return nil }
        blackTransparentFilter.setValue(self, forKey: "inputImage")
        return blackTransparentFilter.outputImage
    }

    func tinted(using color: UIColor) -> CIImage? {
        guard
            let transparentQRImage = transparent,
            let filter = CIFilter(name: "CIMultiplyCompositing"),
            let colorFilter = CIFilter(name: "CIConstantColorGenerator") else { return nil }

        let ciColor = CIColor(color: color)
        colorFilter.setValue(ciColor, forKey: kCIInputColorKey)
        let colorImage = colorFilter.outputImage

        filter.setValue(colorImage, forKey: kCIInputImageKey)
        filter.setValue(transparentQRImage, forKey: kCIInputBackgroundImageKey)

        return filter.outputImage
    }
}
