//
//  DokterAnakTableCell.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 12/04/23.
//

import UIKit

class DokterAnakTableCell: UITableViewCell {

    static let identifier = "DokterAnakTableCell"
    var homeVCDelegate: HomeViewControllerDelegate?
    var modelHome: [Home]?
    var drAnakColCell: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.masksToBounds = false
        return collectionView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setDokterAnakColView() {
        drAnakColCell.delegate = self
        drAnakColCell.dataSource = self
        drAnakColCell.register(UINib(nibName: "TreatmentCategoryColCell", bundle: nil), forCellWithReuseIdentifier: TreatmentCategoryColCell.identifier)
        setColViewConstraint()
    }
    
    func setColViewConstraint() {
        contentView.addSubview(drAnakColCell)
        contentView.backgroundColor = .clear
        
        drAnakColCell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            drAnakColCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            drAnakColCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            drAnakColCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            drAnakColCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            drAnakColCell.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
}

extension DokterAnakTableCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = drAnakColCell.dequeueReusableCell(withReuseIdentifier: TreatmentCategoryColCell.identifier, for: indexPath) as? TreatmentCategoryColCell else { return UICollectionViewCell() }
        if let homeData = modelHome?[3] {
            cell.setData(homeItems: homeData.items[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2, height: 225)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.homeVCDelegate?.directToListPage(index: 2)
    }
}
