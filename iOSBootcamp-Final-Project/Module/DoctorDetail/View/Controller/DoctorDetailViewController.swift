//
//  DoctorDetailViewController.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 10/04/23.
//

import UIKit

class DoctorDetailViewController: UIViewController {

//    @IBOutlet weak var priceLabel: UILabel!
//    @IBOutlet weak var previousPriceLabel: UILabel!
//    @IBOutlet weak var consultButton: UIButton!
//    @IBOutlet weak var consultView: UIView!
    
    var doctorDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
    }
    
    func registerTableView() {
        doctorDetailTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        doctorDetailTableView.dataSource = self
        doctorDetailTableView.delegate = self
        doctorDetailTableView.register(UINib(nibName: "HeaderDoctorTableViewCell", bundle: nil), forCellReuseIdentifier: HeaderDoctorTableViewCell.identifier)
        self.view.addSubview(doctorDetailTableView)
    }
}

extension DoctorDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = doctorDetailTableView.dequeueReusableCell(withIdentifier: HeaderDoctorTableViewCell.identifier, for: indexPath) as? HeaderDoctorTableViewCell else { return UITableViewCell() }
        return cell
    }
}
