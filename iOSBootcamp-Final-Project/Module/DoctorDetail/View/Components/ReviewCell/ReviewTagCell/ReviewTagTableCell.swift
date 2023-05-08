//
//  ReviewTagTableCell.swift
//  iOSBootcamp-Final-Project
//
//  Created by Zahira Rahma on 30/04/23.
//

import UIKit

class ReviewTagTableCell: UITableViewCell {

    static let identifier = "ReviewTagTableCell"
    var doctorDetail: DoctorsByCategory?
    var reviewTagColView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.layer.masksToBounds = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setColViewDelegate() {
        reviewTagColView.delegate = self
        reviewTagColView.dataSource = self
        reviewTagColView.register(UINib(nibName: "ReviewTagColCell", bundle: nil), forCellWithReuseIdentifier: ReviewTagColCell.identifier)
        setColViewConstraint()
    }

    func setColViewConstraint() {
        contentView.addSubview(reviewTagColView)
        
        reviewTagColView.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        NSLayoutConstraint.activate([
            reviewTagColView.topAnchor.constraint(equalTo: contentView.topAnchor),
            reviewTagColView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor),
            reviewTagColView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            reviewTagColView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            reviewTagColView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}

extension ReviewTagTableCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = reviewTagColView.dequeueReusableCell(withReuseIdentifier: ReviewTagColCell.identifier, for: indexPath) as? ReviewTagColCell else { return UICollectionViewCell() }
        
        if let reviews = doctorDetail?.reviews[indexPath.row] {
            cell.tagLabel.text = reviews.tag
            cell.reviewerCountLabel.text = "\(reviews.tagCount)"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2.3, height: 34)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
    }
}
