//
//  ColorPickerViewController.swift
//  Covid Pass
//
//  Created by Nikoloz Tatunashvili on 18.11.21.
//

import UIKit

class ColorPickerViewController: UIColorPickerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        supportsAlpha = false
        sheetSize()
    }

    private func sheetSize() {
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [.large()]
        }
    }
}
