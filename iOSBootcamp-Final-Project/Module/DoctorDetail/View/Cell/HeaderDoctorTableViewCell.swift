//
//  HeaderDoctorTableViewCell.swift
//  iOSBootcamp-Final-Project
//
//  Created by Zahira Rahma on 26/04/23.
//

import UIKit

class HeaderDoctorTableViewCell: UITableViewCell {

    static let identifier = "HeaderDoctorTableViewCell"
    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var doctorNumberLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewerCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
