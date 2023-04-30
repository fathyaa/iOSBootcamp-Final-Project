//
//  SpecializationTableCell.swift
//  iOSBootcamp-Final-Project
//
//  Created by Zahira Rahma on 30/04/23.
//

import UIKit

class SpecializationTableCell: UITableViewCell {

    static let identifier = "SpecializationTableCell"
    var specializationLabel: UILabel = {
        let specLabel = UILabel()
        specLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        specLabel.numberOfLines = 0
        specLabel.lineBreakMode = .byWordWrapping
        specLabel.textAlignment = .justified
        specLabel.translatesAutoresizingMaskIntoConstraints = false
        specLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        return specLabel
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setSpecCell(){
        self.addSubview(specializationLabel)
        
        NSLayoutConstraint.activate([
            specializationLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            specializationLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            specializationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            specializationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
}
