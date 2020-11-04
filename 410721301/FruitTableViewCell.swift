//
//  FruitTableViewCell.swift
//  410721301
//
//  Created by 楊智崴 on 2020/11/2.
//

import UIKit

class FruitTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet var namesLabel: UILabel!
    @IBOutlet var pricesLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
}
