//
//  HomeViewController.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 10/04/23.
//

import UIKit

enum HomeSection: Int {
    case topMenu
    case promotionBanner
    case carouselBanner
    case drKandunganCategory

    init(_ section: Int){
        switch section {
        case 0:
            self = .topMenu
        case 1:
            self = .promotionBanner
        case 2:
            self = .carouselBanner
        case 3:
            self = .drKandunganCategory
        default:
            self = .promotionBanner
        }
    }
}

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    func setTableView(){
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.register(TopMenuTableCell.self, forCellReuseIdentifier: TopMenuTableCell.identifier)
        homeTableView.register(UINib(nibName: "BannerTableCell", bundle: nil), forCellReuseIdentifier: BannerTableCell.identifier)
        homeTableView.register(CarouselTableCell.self, forCellReuseIdentifier: CarouselTableCell.identifier)
        homeTableView.register(DokterKandunganTableCell.self, forCellReuseIdentifier: DokterKandunganTableCell.identifier)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch HomeSection(indexPath.section) {
        case .topMenu:
            guard let cell = homeTableView.dequeueReusableCell(withIdentifier: TopMenuTableCell.identifier, for: indexPath) as? TopMenuTableCell else { return UITableViewCell() }
            cell.setColViewDelegate()
            return cell
        case .promotionBanner:
            guard let cell = homeTableView.dequeueReusableCell(withIdentifier: BannerTableCell.identifier, for: indexPath) as? BannerTableCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            return cell
        case .carouselBanner:
            guard let cell = homeTableView.dequeueReusableCell(withIdentifier: CarouselTableCell.identifier, for: indexPath) as? CarouselTableCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            cell.setColViewDelegate()
            return cell
        case .drKandunganCategory:
            guard let cell = homeTableView.dequeueReusableCell(withIdentifier: DokterKandunganTableCell.identifier, for: indexPath) as? DokterKandunganTableCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            cell.setColViewDelegate()
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch HomeSection(section) {
        case .topMenu, .promotionBanner, .carouselBanner:
            return nil
        case .drKandunganCategory:
            let headerView = UITableViewHeaderFooterView()
            
            let sectionTitleLabel = UILabel()
            sectionTitleLabel.text = "Konsultasi Dokter Spesialis Kandungan"
            sectionTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            sectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let sectionSubTitleLabel = UILabel()
            sectionSubTitleLabel.text = "Punya Keluhan berikut? Yuk, chat dokter kandungan mulai dari 25RB!"
            sectionSubTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
            sectionSubTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            sectionSubTitleLabel.lineBreakMode = .byWordWrapping
            sectionSubTitleLabel.numberOfLines = 0
            
            headerView.addSubview(sectionTitleLabel)
            headerView.addSubview(sectionSubTitleLabel)
            NSLayoutConstraint.activate([
                sectionTitleLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
                sectionTitleLabel.bottomAnchor.constraint(equalTo: sectionSubTitleLabel.bottomAnchor, constant: -25),
                sectionTitleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
                sectionTitleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
                sectionSubTitleLabel.topAnchor.constraint(equalTo: sectionTitleLabel.topAnchor, constant: 20),
                sectionSubTitleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -15),
                sectionSubTitleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
                sectionSubTitleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15)
            ])
            
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        switch HomeSection(section){
        case .topMenu, .promotionBanner, .carouselBanner:
            return 0
        case .drKandunganCategory:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 3 {
            return 60
        }
        return 0
    }
}
