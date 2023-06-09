//
//  ShowAllViewController.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 10/04/23.
//

import UIKit

class DoctorListViewController: UIViewController {
    
    @IBOutlet weak var doctorListColView: UICollectionView!
    var doctorListViewModel: DoctorListViewModel?
    var modelDoctors: [Doctors]?
    /// variable untuk menentukan index di json agar datanya sesuai dengan yang mau ditampilkan. Var indexSelected di-pass oleh parameter index di func directToListPage
    var categorySelected: Category?
    var doctorItems = [DoctorsByCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDoctorListColView()
        bindAPIData()
    }
    
    /// func untuk set doctor list collection view
    func setDoctorListColView() {
        doctorListColView.delegate = self
        doctorListColView.dataSource = self
        doctorListColView.register(UINib(nibName: "DoctorCardColViewCell", bundle: nil), forCellWithReuseIdentifier: DoctorCardColViewCell.identifier)
    }
    
    /// func untuk bind data dari API, lalu dimasukkan ke modelDoctors
    func bindAPIData() {
        self.doctorListViewModel = DoctorListViewModel(urlString: "http://localhost:3003/doctors", apiService: ApiService())
        self.doctorListViewModel?.bindDoctorsData = { [weak self] doctorsData in
            if let modelData = doctorsData {
                for data in modelData[0..<modelData.count] {
                    if data.category == self?.categorySelected?.rawValue {
                        self?.doctorItems.append(contentsOf: data.items)
                    }
                }
//                self.modelDoctors = modelData
            } else {
                self?.doctorListColView.backgroundColor = .red
            }
            print("reload data")
            DispatchQueue.main.async {
                self?.doctorListColView.reloadData()
            }
        }
    }
}

extension DoctorListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doctorItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =
                doctorListColView.dequeueReusableCell(withReuseIdentifier: DoctorCardColViewCell.identifier, for: indexPath) as? DoctorCardColViewCell else { return UICollectionViewCell() }
        // ambil data modelDoctor di index ke-indexSelected
        cell.setData(doctors: doctorItems[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "doctorDetailVC") as! DoctorDetailViewController
        
        // pass data dokter yang diklik ke detailDoctorVC
        viewController.doctorDetail = doctorItems[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}
