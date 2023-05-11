//
//  DokterKandunganTableCell.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 12/04/23.
//

import UIKit

class DokterKandunganTableCell: UITableViewCell {

    static let identifier = "DokterKandunganTableCell"
    var homeVCDelegate: HomeViewControllerDelegate?
    var drKandunganItems: [Items]?
    var drKandunganColView: UICollectionView = {
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
    }

    func setDokterKandunganColView() {
        drKandunganColView.delegate = self
        drKandunganColView.dataSource = self
        drKandunganColView.register(UINib(nibName: "TreatmentCategoryColCell", bundle: nil), forCellWithReuseIdentifier: TreatmentCategoryColCell.identifier)
        setColViewConstraint()
    }
    
    func setColViewConstraint() {
        contentView.addSubview(drKandunganColView)
        contentView.backgroundColor = .clear
        
        drKandunganColView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            drKandunganColView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            drKandunganColView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            drKandunganColView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            drKandunganColView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            drKandunganColView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
}

extension DokterKandunganTableCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drKandunganItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = drKandunganColView.dequeueReusableCell(withReuseIdentifier: TreatmentCategoryColCell.identifier, for: indexPath) as? TreatmentCategoryColCell else { return UICollectionViewCell() }
        // data untuk kategori ini berada di index ke-1 di jsonnya (/home), jadi indexnya dibuat 1
        if let items = drKandunganItems {
            cell.setData(homeItems: items[indexPath.row])
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
        /// data doctor untuk kategori ini berada di index ke-0 di jsonnya (/doctor), jadi indexnya dibuat 0
        let index = 0
        self.homeVCDelegate?.directToListPage(index: index)
    }
}
