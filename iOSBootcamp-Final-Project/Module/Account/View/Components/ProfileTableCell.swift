//
//  ProfileTableCell.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 03/05/23.
//

import UIKit

class ProfileTableCell: UITableViewCell {

    static let identifier = "ProfileTableCell"
    @IBOutlet weak var profileView: UIView!{
        didSet{
            profileView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(user: User?) {
        nameLabel.text = user?.name
        infoLabel.text = user?.email
    }
}
