//
//  HomeViewController.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 10/04/23.
//

import UIKit

protocol HomeViewControllerDelegate {
    func directToDetailPage()
}

enum HomeSection: Int {
    case topMenu
    case promotionBanner
    case carouselBanner
    case drKandunganCategory
    case topTips
    case topThreeTips
    case categoriesTips

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
        case 4:
            self = .topTips
        case 5:
            self = .topThreeTips
        case 6:
            self = .categoriesTips
        default:
            self = .promotionBanner
        }
    }
}

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet var homeSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        navigationItem.titleView = homeSearchBar
    }
    
    func setTableView() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.register(TopMenuTableCell.self, forCellReuseIdentifier: TopMenuTableCell.identifier)
        homeTableView.register(UINib(nibName: "BannerTableCell", bundle: nil), forCellReuseIdentifier: BannerTableCell.identifier)
        homeTableView.register(CarouselTableCell.self, forCellReuseIdentifier: CarouselTableCell.identifier)
        homeTableView.register(DokterKandunganTableCell.self, forCellReuseIdentifier: DokterKandunganTableCell.identifier)
        homeTableView.register(UINib(nibName: "TopTipsTableCell", bundle: nil), forCellReuseIdentifier: TopTipsTableCell.identifier)
        homeTableView.register(UINib(nibName: "TopThreeTipsTableCell", bundle: nil), forCellReuseIdentifier: TopThreeTipsTableCell.identifier)
        homeTableView.register(TipsCategoriesTableCell.self, forCellReuseIdentifier: TipsCategoriesTableCell.identifier)
        
        homeTableView.sectionFooterHeight = 0.0
        homeTableView.sectionHeaderHeight = 0.0
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 5 {
            return 3
        }
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
            cell.homeVCDelegate = self
            cell.setColViewDelegate()
            return cell
        case .topTips:
            guard let cell = homeTableView.dequeueReusableCell(withIdentifier: TopTipsTableCell.identifier, for: indexPath) as? TopTipsTableCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            return cell
        case .topThreeTips:
            guard let cell = homeTableView.dequeueReusableCell(withIdentifier: TopThreeTipsTableCell.identifier, for: indexPath) as? TopThreeTipsTableCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            return cell
        case .categoriesTips:
            guard let cell = homeTableView.dequeueReusableCell(withIdentifier: TipsCategoriesTableCell.identifier, for: indexPath) as? TipsCategoriesTableCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            cell.setColViewDelegate()
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch HomeSection(section) {
        case .topMenu, .promotionBanner, .carouselBanner, .topThreeTips, .categoriesTips:
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
                sectionTitleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15),
                sectionTitleLabel.bottomAnchor.constraint(equalTo: sectionSubTitleLabel.bottomAnchor, constant: -25),
                sectionTitleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
                sectionTitleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
                sectionSubTitleLabel.topAnchor.constraint(equalTo: sectionTitleLabel.topAnchor, constant: 15),
                sectionSubTitleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -25),
                sectionSubTitleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
                sectionSubTitleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15)
            ])
            return headerView
        case .topTips:
            let tipsHeaderView = UITableViewHeaderFooterView()
            
            let bgView = UIView()
            bgView.clipsToBounds = true
            bgView.layer.cornerRadius = 20
            bgView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            bgView.backgroundColor = .white
            bgView.translatesAutoresizingMaskIntoConstraints = false
            
            let sectionTitle = UILabel()
            sectionTitle.text = "Your Good Tips!"
            sectionTitle.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            sectionTitle.translatesAutoresizingMaskIntoConstraints = false
            
            tipsHeaderView.addSubview(bgView)
            bgView.addSubview(sectionTitle)
            
            NSLayoutConstraint.activate([
                bgView.topAnchor.constraint(equalTo: tipsHeaderView.topAnchor, constant: 20),
                bgView.bottomAnchor.constraint(equalTo: tipsHeaderView.bottomAnchor),
                bgView.leadingAnchor.constraint(equalTo: tipsHeaderView.leadingAnchor, constant: 15),
                bgView.trailingAnchor.constraint(equalTo: tipsHeaderView.trailingAnchor, constant: -15),
                sectionTitle.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -10),
                sectionTitle.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 10),
                sectionTitle.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 15),
                sectionTitle.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -15)
            ])
            return tipsHeaderView
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        switch HomeSection(section){
        case .topMenu, .promotionBanner, .carouselBanner, .topThreeTips, .categoriesTips:
            return 0
        case .drKandunganCategory, .topTips:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch HomeSection(section) {
        case .drKandunganCategory:
            return 85
        case .topTips:
            return 60
        case .topMenu, .promotionBanner, .carouselBanner, .topThreeTips, .categoriesTips:
            return 0
        }
    }
}

extension HomeViewController: HomeViewControllerDelegate {
    func directToDetailPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "doctorListVC") as! DoctorListViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}
