//
//  TipsCategoriesColCell.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 13/04/23.
//

import UIKit

class TipsCategoriesColCell: UICollectionViewCell {

    static let identifier = "TipsCategoriesColCell"
    @IBOutlet weak var bgView: UIView!{
        didSet{
            bgView.layer.contents = #imageLiteral(resourceName: "food").cgImage
            // #imageLiteral(resourceName: "webbg").cgImage
            bgView.layer.cornerRadius = 20
            bgView.clipsToBounds = true
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buttonOne: UIButton!{
        didSet{
            buttonOne.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var buttonTwo: UIButton!{
        didSet{
            buttonTwo.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var buttonThree: UIButton!{
        didSet{
            buttonThree.layer.cornerRadius = 10
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
