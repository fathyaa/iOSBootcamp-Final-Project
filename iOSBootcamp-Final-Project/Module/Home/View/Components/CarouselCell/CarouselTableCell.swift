//
//  CarouselTableCell.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 12/04/23.
//

import UIKit

class CarouselTableCell: UITableViewCell {
    
    static let identifier = "CarouselTableCell"
    var carouselColView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.layer.masksToBounds = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let carouselImg = ["banner-carousel-1", "banner-carousel-2"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCarouselColView() {
        carouselColView.dataSource = self
        carouselColView.delegate = self
        carouselColView.isPagingEnabled = true
        carouselColView.showsHorizontalScrollIndicator = false
        carouselColView.register(UINib(nibName: "CarouselColCell", bundle: nil), forCellWithReuseIdentifier: CarouselColCell.identifier)
        setColViewConstraint()
    }
    
    func setColViewConstraint() {
        let carouselView = UIView(frame: CGRect(x: 15, y: 15, width: 360, height: 150))
        contentView.addSubview(carouselView)
        carouselView.addSubview(carouselColView)
        
        carouselView.clipsToBounds = true
        carouselView.layer.cornerRadius = 20
        contentView.backgroundColor = .clear
        
        carouselColView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            carouselView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            carouselView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            carouselView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            carouselView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            carouselView.heightAnchor.constraint(equalToConstant: 150),
            carouselColView.topAnchor.constraint(equalTo: carouselView.topAnchor),
            carouselColView.bottomAnchor.constraint(equalTo: carouselView.bottomAnchor),
            carouselColView.trailingAnchor.constraint(equalTo: carouselView.trailingAnchor),
            carouselColView.leadingAnchor.constraint(equalTo: carouselView.leadingAnchor),
            carouselColView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
}

extension CarouselTableCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselImg.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = carouselColView.dequeueReusableCell(withReuseIdentifier: CarouselColCell.identifier, for: indexPath) as? CarouselColCell else { return UICollectionViewCell() }
        cell.carouselImage.image = UIImage(named: carouselImg[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
