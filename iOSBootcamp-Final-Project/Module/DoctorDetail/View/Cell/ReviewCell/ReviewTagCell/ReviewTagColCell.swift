//
//  ReviewTagColCell.swift
//  iOSBootcamp-Final-Project
//
//  Created by Zahira Rahma on 30/04/23.
//

import UIKit

class ReviewTagColCell: UICollectionViewCell {

    static let identifier = "ReviewTagColCell"
    @IBOutlet weak var reviewTagView: UIView!{
        didSet{
            reviewTagView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var reviewerCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
