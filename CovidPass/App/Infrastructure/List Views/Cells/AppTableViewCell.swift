//
//  AppTableViewCell.swift
//  Business
//
//  Created by Nikoloz Tatunashvili on 07.02.21.
//

import UIKit

public class AppTableViewCell: UITableViewCell {
    override open func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
