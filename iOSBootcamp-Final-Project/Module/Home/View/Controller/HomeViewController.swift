//
//  HomeViewController.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 10/04/23.
//

import UIKit

/// ketika collectionviewcell yang ada di dalam hometableview diklik, maka akan direct ke listviewcontroller dengan menggunakan bantuan protocol ini
protocol HomeViewControllerDelegate {
    func directToListPage(category: Category)
}

/// enum untuk menamakan index section di hometableview
enum HomeSection: Int {
    case topMenu
    case promotionBanner
    case carouselBanner
    case drKandunganCategory
    case drPenyakitDalamCategory
    case drSpesialisAnakCategory
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
            self = .drPenyakitDalamCategory
        case 5:
            self = .drSpesialisAnakCategory
        case 6:
            self = .topTips
        case 7:
            self = .topThreeTips
        case 8:
            self = .categoriesTips
        default:
            self = .promotionBanner
        }
    }
}

enum Category: String {
    case drKandunganCategory = "drKandunganCategory"
    case drPenyakitDalamCategory = "drPenyakitDalamCategory"
    case drAnakCategory = "drAnakCategory"
}

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet var homeSearchBar: UISearchBar!
    var homeViewModel: HomeViewModel?
    // declare model Home
    var modelHome: [Home]?
    var drKandunganItems = [Items]()
    var drPenyakitDalamItems = [Items]()
    var drAnakItems = [Items]()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Your Name"
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return lbl
    }()
    
    let addressLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Jl. Your address will appear here"
        lbl.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return lbl
    }()
    
    let notifButtonImage: UIImageView = {
        let btnImage = UIImageView()
        btnImage.image = UIImage(systemName: "bell.fill")
        btnImage.tintColor = UIColor(named: "theme-color")
        btnImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return btnImage
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setHomeTableView()
        bindAPIData()
        fetchUserInHome()
    }
    
    /// func untuk set Navbar di home page
    func setNavBar(){
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // buat stackview untuk label nama dan alamat
        let leftStackView = UIStackView(arrangedSubviews: [nameLabel, addressLabel])
        leftStackView.spacing = 1
        leftStackView.axis = .vertical
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftStackView)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: notifButtonImage)
    }
    
    /// func untuk set Home table view
    func setHomeTableView() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.register(TopMenuTableCell.self, forCellReuseIdentifier: TopMenuTableCell.identifier)
        homeTableView.register(UINib(nibName: "BannerTableCell", bundle: nil), forCellReuseIdentifier: BannerTableCell.identifier)
        homeTableView.register(CarouselTableCell.self, forCellReuseIdentifier: CarouselTableCell.identifier)
        homeTableView.register(DokterKandunganTableCell.self, forCellReuseIdentifier: DokterKandunganTableCell.identifier)
        homeTableView.register(DokterPenyakitDalamTableCell.self, forCellReuseIdentifier: DokterPenyakitDalamTableCell.identifier)
        homeTableView.register(DokterAnakTableCell.self, forCellReuseIdentifier: DokterAnakTableCell.identifier)
        homeTableView.register(UINib(nibName: "TopTipsTableCell", bundle: nil), forCellReuseIdentifier: TopTipsTableCell.identifier)
        homeTableView.register(UINib(nibName: "TopThreeTipsTableCell", bundle: nil), forCellReuseIdentifier: TopThreeTipsTableCell.identifier)
        homeTableView.register(TipsCategoriesTableCell.self, forCellReuseIdentifier: TipsCategoriesTableCell.identifier)
        
        // set section footer & header height
        homeTableView.sectionFooterHeight = 0.0
        homeTableView.sectionHeaderHeight = 0.0
    }
    
    /// function untuk bind data dari api, lalu dimasukkan ke modelHome
    func bindAPIData() {
        self.homeViewModel = HomeViewModel(urlString: "http://localhost:3003/home", apiService: ApiService())
        self.homeViewModel?.bindHomeData = { homeData in
            if let modelData = homeData {
                for data in modelData[0..<modelData.count] {
                    if data.pageSection == "drKandunganCategory" {
                        self.drKandunganItems.append(contentsOf: data.items)
                    } else if data.pageSection == "drPenyakitDalamCategory" {
                        self.drPenyakitDalamItems.append(contentsOf: data.items)
                    } else if data.pageSection == ("drAnakCategory") {
                        self.drAnakItems.append(contentsOf: data.items)
                    }
                }
            } else {
                self.homeTableView.backgroundColor = .red
            }
            print("reload data")
            DispatchQueue.main.async {
                self.homeTableView.reloadData()
            }
        }
    }
    
    /// function untuk mengambil data user dari firebase dan menampilkan datanya ke nameLabel
    func fetchUserInHome() {
        AuthService.shared.fetchUser { [weak self] user, error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showFetchingUserError(on: self, with: error)
                return
            }
            
            if let user = user {
                self.nameLabel.text = user.name
            }
        }
    }
}

extension HomeViewController: HomeViewControllerDelegate {
    /// Function direct to list page ketika doctor category diklik. Section di HomeTableView yg membutuhkan function ini: .drKandunganCategory, .drPenyakitDalamCategory, .drSpesialisAnakCategory
    func directToListPage(category: Category) {
        /// definisikan storyboard karena VC-nya menggunakan storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        /// instantiasi VC yg  ber-identifier doctorListVC
        let viewController = storyboard.instantiateViewController(withIdentifier: "doctorListVC") as! DoctorListViewController
        viewController.categorySelected = category
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if HomeSection(section) == .topThreeTips {
            return 3
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch HomeSection(indexPath.section) {
        case .topMenu:
            guard let cell = homeTableView.dequeueReusableCell(withIdentifier: TopMenuTableCell.identifier, for: indexPath) as? TopMenuTableCell else { return UITableViewCell() }
            cell.setTopMenuColView()
            return cell
        case .promotionBanner:
            guard let cell = homeTableView.dequeueReusableCell(withIdentifier: BannerTableCell.identifier, for: indexPath) as? BannerTableCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            return cell
        case .carouselBanner:
            guard let cell = homeTableView.dequeueReusableCell(withIdentifier: CarouselTableCell.identifier, for: indexPath) as? CarouselTableCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            cell.setCarouselColView()
            return cell
        case .drKandunganCategory:
            guard let cell = homeTableView.dequeueReusableCell(withIdentifier: DokterKandunganTableCell.identifier, for: indexPath) as? DokterKandunganTableCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            cell.homeVCDelegate = self
            cell.drKandunganItems = drKandunganItems
            cell.setDokterKandunganColView()
            return cell
        case .drPenyakitDalamCategory:
            guard let cell = homeTableView.dequeueReusableCell(withIdentifier: DokterPenyakitDalamTableCell.identifier, for: indexPath) as? DokterPenyakitDalamTableCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            cell.homeVCDelegate = self
            cell.drPenyakitDalamItems = drPenyakitDalamItems
            cell.setDokterPenyakitDalamColView()
            return cell
        case .drSpesialisAnakCategory:
            guard let cell = homeTableView.dequeueReusableCell(withIdentifier: DokterAnakTableCell.identifier, for: indexPath) as? DokterAnakTableCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            cell.homeVCDelegate = self
            cell.drAnakItems = drAnakItems
            cell.setDokterAnakColView()
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
            cell.setTipsCategoriesColView()
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch HomeSection(section) {
        case .topMenu, .promotionBanner, .carouselBanner, .topThreeTips, .categoriesTips:
            return nil
        // set header view untuk di section berikut
        case .drKandunganCategory, .drPenyakitDalamCategory, .drSpesialisAnakCategory:
            /// wadah untuk header
            let headerView = UITableViewHeaderFooterView()
            
            /// komponen yang akan dimasukkan ke headerview
            let sectionTitleLabel = UILabel()
            sectionTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            sectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let sectionSubTitleLabel = UILabel()
            sectionSubTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
            sectionSubTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            sectionSubTitleLabel.lineBreakMode = .byWordWrapping
            sectionSubTitleLabel.numberOfLines = 0
            
            // set text sesuai section
            if HomeSection(section) == .drKandunganCategory {
                sectionTitleLabel.text = "Konsultasi Dokter Spesialis Kandungan"
                sectionSubTitleLabel.text = "Punya Keluhan berikut? Yuk, chat dokter kandungan mulai dari 25RB!"
            } else if HomeSection(section) == .drPenyakitDalamCategory {
                sectionTitleLabel.text = "Chat Dokter Spesialis Penyakit Dalam"
                sectionSubTitleLabel.text = "Mulai dari 25RB! Atasi keluhan berikut:"
            } else if HomeSection(section) == .drSpesialisAnakCategory {
                sectionTitleLabel.text = "Pilih Yang Baik Untuk Kesehatan Si Kecil"
                sectionSubTitleLabel.text = "Chat dokter spesialis anak untuk atasi keluhan berikut:"
            }
            
            // masukkan komponen ke headerview
            headerView.addSubview(sectionTitleLabel)
            headerView.addSubview(sectionSubTitleLabel)
            
            // set constraint untuk components di headerview
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
            
            /// buat view yang rounded di header section toptips
            let bgView = UIView()
            bgView.clipsToBounds = true
            bgView.layer.cornerRadius = 20
            bgView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            bgView.backgroundColor = .white
            bgView.translatesAutoresizingMaskIntoConstraints = false
            
            /// buat label untuk judul
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
    
    // ketika diklik gak akan ada effect highlight
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch HomeSection(section) {
        case .drKandunganCategory, .drPenyakitDalamCategory, .drSpesialisAnakCategory:
            return 85
        case .topTips:
            return 60
        case .topMenu:
            return 50
        case .promotionBanner, .carouselBanner, .topThreeTips, .categoriesTips:
            return 0
        }
    }
}
