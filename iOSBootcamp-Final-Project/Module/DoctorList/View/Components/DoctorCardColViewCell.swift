//
//  DoctorCardColViewCell.swift
//  iOSBootcamp-Final-Project
//
//  Created by Zahira Rahma on 23/04/23.
//

import UIKit
import SDWebImage

class DoctorCardColViewCell: UICollectionViewCell {

    static let identifier = "DoctorCardColViewCell"
    @IBOutlet weak var cardView: UIView!{
        didSet{
            cardView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var doctorDescLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(doctors: Doctors){
        doctorNameLabel.text = "dr. " + (doctors.nama.components(separatedBy: " ").first ?? " ")
        doctorDescLabel.text = doctors.spesialis + " - \(doctors.tahunPengalaman) tahun"
        priceLabel.text = doctors.price
        doctorImage.sd_setImage(with: URL(string: doctors.doctorImg))
    }

}
