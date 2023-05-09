//
//  BannerTableCell.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 11/04/23.
//

import UIKit

class BannerTableCell: UITableViewCell {

    static let identifier = "BannerTableCell"
    @IBOutlet weak var bannerImage: UIImageView!{
        didSet{
            bannerImage.layer.cornerRadius = 20
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
