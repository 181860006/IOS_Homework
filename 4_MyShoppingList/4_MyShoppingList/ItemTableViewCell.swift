//
//  ItemTableViewCell.swift
//  4_MyShoppingList
//
//  Created by 陈劭彬 on 2020/11/7.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var displayReason: UILabel!
    @IBOutlet weak var displayPhoto: UIImageView!
}
