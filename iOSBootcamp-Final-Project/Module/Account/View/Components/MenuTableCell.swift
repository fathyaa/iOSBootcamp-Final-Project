//
//  MenuTableCell.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 02/05/23.
//

import UIKit

class MenuTableCell: UITableViewCell {

    static let identifier = "MenuTableCell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(menuItems: AccountItems?) {
        titleLabel.text = menuItems?.title
        subtitleLabel.text = menuItems?.subtitle
        iconImage.image = UIImage(systemName: menuItems?.iconImg ?? "")
    }
    
}
