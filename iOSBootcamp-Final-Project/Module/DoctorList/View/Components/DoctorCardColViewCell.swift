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
    
    func setData(doctors: Doctors?, index: Int){
        doctorNameLabel.text = "dr. " + ((doctors?.items[index].nama ?? "").components(separatedBy: " ").first ?? "")
        doctorDescLabel.text = (doctors?.items[index].spesialis ?? "") + " - \(doctors?.items[index].tahunPengalaman ?? 0) tahun"
        priceLabel.text = doctors?.items[index].price
        doctorImage.sd_setImage(with: URL(string: doctors?.items[index].doctorImg ?? ""))
    }

}
