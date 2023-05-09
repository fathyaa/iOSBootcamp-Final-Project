//
//  DokterPenyakitDalamTableCell.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 12/04/23.
//

import UIKit

class DokterPenyakitDalamTableCell: UITableViewCell {

    static let identifier = "DokterPenyakitDalamTableCell"
    var homeVCDelegate: HomeViewControllerDelegate?
    var modelHome: [Home]?
    var drPenyakitDalamColView: UICollectionView = {
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

    func setDokterPenyakitDalamColView() {
        drPenyakitDalamColView.delegate = self
        drPenyakitDalamColView.dataSource = self
        drPenyakitDalamColView.register(UINib(nibName: "TreatmentCategoryColCell", bundle: nil), forCellWithReuseIdentifier: TreatmentCategoryColCell.identifier)
        setColViewConstraint()
    }
    
    func setColViewConstraint() {
        contentView.addSubview(drPenyakitDalamColView)
        contentView.backgroundColor = .clear
        
        drPenyakitDalamColView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            drPenyakitDalamColView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            drPenyakitDalamColView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            drPenyakitDalamColView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            drPenyakitDalamColView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            drPenyakitDalamColView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
}

extension DokterPenyakitDalamTableCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelHome?[2].items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = drPenyakitDalamColView.dequeueReusableCell(withReuseIdentifier: TreatmentCategoryColCell.identifier, for: indexPath) as? TreatmentCategoryColCell else { return UICollectionViewCell() }
        /// data untuk kategori ini berada di index ke-2 di jsonnya (/home), jadi indexnya dibuat 2
        if let homeData = modelHome?[2] {
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
        /// data doctor untuk kategori ini berada di index ke-1 di jsonnya (/doctor), jadi indexnya dibuat 1
        self.homeVCDelegate?.directToListPage(index: 1)
    }
}
