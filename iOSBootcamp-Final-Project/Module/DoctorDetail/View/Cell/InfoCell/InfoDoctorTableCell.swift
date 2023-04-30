//
//  InfoDoctorTableCell.swift
//  iOSBootcamp-Final-Project
//
//  Created by Zahira Rahma on 30/04/23.
//

import UIKit

class InfoDoctorTableCell: UITableViewCell {

    static let identifier = "InfoDoctorTableCell"
    @IBOutlet weak var infoIconImage: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
