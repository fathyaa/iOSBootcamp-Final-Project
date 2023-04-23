//
//  ShowAllViewController.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 10/04/23.
//

import UIKit

class DoctorListViewController: UIViewController {
    
    @IBOutlet weak var doctorListColView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setColView()
    }
    
    func setColView() {
        doctorListColView.delegate = self
        doctorListColView.dataSource = self
        doctorListColView.register(UINib(nibName: "DoctorCardColViewCell", bundle: nil), forCellWithReuseIdentifier: DoctorCardColViewCell.identifier)
    }
}

extension DoctorListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =
                doctorListColView.dequeueReusableCell(withReuseIdentifier: DoctorCardColViewCell.identifier, for: indexPath) as? DoctorCardColViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 210, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
