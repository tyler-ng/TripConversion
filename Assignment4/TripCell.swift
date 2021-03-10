//
//  TripCell.swift
//  Assignment4
//
//  Created by ThanhTy  on 15/11/20.
//  Copyright © 2020 ThanhTy . All rights reserved.
//

import UIKit

class TripCell: UITableViewCell {
    @IBOutlet var sourceLabel: UILabel!
    @IBOutlet var destinationLabel: UILabel!
    @IBOutlet var gasInLiterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sourceLabel?.adjustsFontForContentSizeCategory = true
        destinationLabel?.adjustsFontForContentSizeCategory = true
        gasInLiterLabel.adjustsFontForContentSizeCategory = true
    }
    
    func updateLabels() {
        let bodyFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        sourceLabel?.font = bodyFont
        destinationLabel?.font = bodyFont
        gasInLiterLabel?.font = bodyFont
        let captionFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1)
        gasInLiterLabel?.font = captionFont
    }
}

