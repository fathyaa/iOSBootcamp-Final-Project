//
//  HeaderDoctorTableViewCell.swift
//  iOSBootcamp-Final-Project
//
//  Created by Zahira Rahma on 26/04/23.
//

import UIKit

class HeaderDoctorTableCell: UITableViewCell {

    static let identifier = "HeaderDoctorTableViewCell"
    @IBOutlet weak var doctorImage: UIImageView!{
        didSet{
            doctorImage.layer.cornerRadius = 40
        }
    }
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var doctorNumberLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewerCountLabel: UILabel!
    @IBOutlet weak var experienceYearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(doctor: DoctorsByCategory?) {
        doctorImage.sd_setImage(with: URL(string: doctor?.doctorImg ?? ""))
        doctorNameLabel.text = "dr. " + (doctor?.name ?? "")
        doctorNumberLabel.text = doctor?.doctorNumber ?? ""
        experienceYearLabel.text = "\(doctor?.experienceYear ?? 0) tahun"
        ratingLabel.text = doctor?.rating
        reviewerCountLabel.text = "(\(doctor?.reviewCount ?? 0))"
    }
}
