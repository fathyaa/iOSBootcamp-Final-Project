//
//  TopThreeTipsTableCell.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 13/04/23.
//

import UIKit

class TopThreeTipsTableCell: UITableViewCell {

    static let identifier = "TopThreeTipsTableCell"
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
