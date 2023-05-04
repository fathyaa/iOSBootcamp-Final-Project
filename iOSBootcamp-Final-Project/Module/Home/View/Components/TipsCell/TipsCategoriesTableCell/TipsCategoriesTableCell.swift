//
//  TipsCategoriesTableCell.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 13/04/23.
//

import UIKit

class TipsCategoriesTableCell: UITableViewCell {

    static let identifier = "TipsCategoriesTableCell"
    var tipsCategoriesColView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.layer.masksToBounds = true
        collectionView.layer.cornerRadius = 20
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        return collectionView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setTipsCategoriesColView(){
        tipsCategoriesColView.delegate = self
        tipsCategoriesColView.dataSource = self
        tipsCategoriesColView.register(UINib(nibName: "TipsCategoriesColCell", bundle: nil), forCellWithReuseIdentifier: TipsCategoriesColCell.identifier)
        setColViewConstraint()
    }
    
    func setColViewConstraint() {
        let cellBgView = UIView(frame: CGRect(x: 15, y: 15, width: 360, height: 210))
        cellBgView.layer.cornerRadius = 20
        cellBgView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        cellBgView.backgroundColor = .white
        cellBgView.translatesAutoresizingMaskIntoConstraints = false
        
        tipsCategoriesColView.clipsToBounds = true
        tipsCategoriesColView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(cellBgView)
        cellBgView.addSubview(tipsCategoriesColView)
        
        self.backgroundColor = .clear
        NSLayoutConstraint.activate([
            cellBgView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellBgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            cellBgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            cellBgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            cellBgView.heightAnchor.constraint(equalToConstant: 230),
            tipsCategoriesColView.topAnchor.constraint(equalTo: cellBgView.topAnchor, constant: 10),
            tipsCategoriesColView.bottomAnchor.constraint(equalTo: cellBgView.bottomAnchor, constant: -15),
            tipsCategoriesColView.leadingAnchor.constraint(equalTo: cellBgView.leadingAnchor, constant: 15),
            tipsCategoriesColView.trailingAnchor.constraint(equalTo: cellBgView.trailingAnchor, constant: -15),
            tipsCategoriesColView.heightAnchor.constraint(equalToConstant: 210)
        ])
    }
}

extension TipsCategoriesTableCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = tipsCategoriesColView.dequeueReusableCell(withReuseIdentifier: TipsCategoriesColCell.identifier, for: indexPath) as? TipsCategoriesColCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 210)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}
