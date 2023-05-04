//
//  TopMenuTableCell.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 10/04/23.
//

import UIKit

class TopMenuTableCell: UITableViewCell {

    static let identifier = "TopMenuTableCell"
    var topMenuColView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.layer.masksToBounds = false
        collectionView.layer.cornerRadius = 20
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    var menuIcon = ["stethoscope", "person-pregnant", "doctor", "capsules", "book-medical", "ambulance"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setTopMenuColView() {
        topMenuColView.delegate = self
        topMenuColView.dataSource = self
        topMenuColView.isScrollEnabled = false
        topMenuColView.register(UINib(nibName: "TopMenuColCell", bundle: nil), forCellWithReuseIdentifier: TopMenuColCell.identifier)
        setColViewConstraint()
    }
    
    func setColViewConstraint() {
        contentView.addSubview(topMenuColView)
        
        topMenuColView.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        NSLayoutConstraint.activate([
            topMenuColView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            topMenuColView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            topMenuColView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            topMenuColView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            topMenuColView.heightAnchor.constraint(equalToConstant: 210)
        ])
    }
}

extension TopMenuTableCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = topMenuColView.dequeueReusableCell(withReuseIdentifier: TopMenuColCell.identifier, for: indexPath) as? TopMenuColCell else { return UICollectionViewCell() }
        cell.menuImage.image = UIImage(named: menuIcon[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 3.7, height: 91)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
}
