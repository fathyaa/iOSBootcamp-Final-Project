//
//  TopMenuColCell.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 10/04/23.
//

import UIKit

class TopMenuColCell: UICollectionViewCell {

    static let identifier = "TopMenuColCell"
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var imageBgView: UIView!{
        didSet{
            imageBgView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var colCellBgView: UIView!{
        didSet{
            colCellBgView.layer.cornerRadius = 10
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(homeItems: Items?){
        menuImage.sd_setImage(with: URL(string: homeItems?.thumbnailImg ?? "https://i.ibb.co/jZq7FW0/stethoscope.png"))
        menuLabel.text = homeItems?.title ?? "Not defined"
    }
}
