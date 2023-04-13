//
//  TopTipsTableCell.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 13/04/23.
//

import UIKit

class TopTipsTableCell: UITableViewCell {

    static let identifier = "TopTipsTableCell"
    @IBOutlet weak var coverImage: UIImageView!{
        didSet{
            coverImage.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
