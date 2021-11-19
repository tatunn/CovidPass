//
//  UIViewController+Extensions.swift
//  Nikora
//
//  Created by Nikoloz Tatunashvili on 12.04.21.
//

import Foundation

import UIKit

extension UIViewController {
    func addTapOutsideCloseKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmisKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dissmisKeyboard() {
        view.endEditing(true)
    }

    func presentError(title: String? = nil, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: R.string.localizable.alertOk.localized, style: .cancel, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
}
