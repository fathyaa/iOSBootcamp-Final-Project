//
//  TreatmentCategoryColCell.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 10/04/23.
//

import UIKit

class TreatmentCategoryColCell: UICollectionViewCell {

    static let identifier = "TreatmentCategoryColCell"
    @IBOutlet weak var descView: UIView!{
        didSet{
            descView.roundCorners(corners: [.topRight, .bottomLeft, .bottomRight], radius: 20)
        }
    }
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var categoryIcon: UIImageView!{
        didSet{
            categoryIcon.layer.cornerRadius = categoryIcon.frame.size.height / 2
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(homeItems: Items?){
        coverImage.sd_setImage(with: URL(string: homeItems?.thumbnailImg ?? ""))
        titleLabel.text = homeItems?.title
        
        if homeItems?.category == "kandunganKebidanan" {
            categoryIcon.image = UIImage(systemName: "pills.circle")
            subtitleLabel.text = "Konsultasi ke spesialis kebidanan"
        }
        
        if homeItems?.category == "penyakitDalam" {
            categoryIcon.image = UIImage(systemName: "heart.circle")
            subtitleLabel.text = "Konsultasi ke spesialis penyakit dalam"
        }
        
        if homeItems?.category == "spesialisAnak" {
            categoryIcon.image = UIImage(systemName: "stethoscope.circle.fill")
            subtitleLabel.text = "Konsultasi ke spesialis anak"
        }
    }
}
