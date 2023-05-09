//
//  DoctorDetailViewController.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 10/04/23.
//

import UIKit

enum DoctorDetailSection: Int {
    case header
    case info
    case specialization
    case reviewStar
    case reviewTag
    
    init(_ section: Int){
        switch section{
        case 0:
            self = .header
        case 1:
            self = .info
        case 2:
            self = .specialization
        case 3:
            self = .reviewStar
        case 4:
            self = .reviewTag
        default:
            self = .info
        }
    }
}

class DoctorDetailViewController: UIViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var previousPriceLabel: UILabel!
    @IBOutlet weak var consultButton: UIButton!{
        didSet{
            consultButton.tintColor = UIColor(named: "theme-color")
            consultButton.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var consultView: UIView!
    
    var doctorDetailTableView: UITableView!
    var doctorDetail: DoctorsByCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDoctorDetailTableView()
        setPrice()
    }
    
    func setDoctorDetailTableView() {
        doctorDetailTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 650))
        doctorDetailTableView.separatorStyle = .none
        doctorDetailTableView.dataSource = self
        doctorDetailTableView.delegate = self
        doctorDetailTableView.backgroundColor = .clear
        doctorDetailTableView.register(UINib(nibName: "HeaderDoctorTableCell", bundle: nil), forCellReuseIdentifier: HeaderDoctorTableCell.identifier)
        doctorDetailTableView.register(UINib(nibName: "InfoDoctorTableCell", bundle: nil), forCellReuseIdentifier: InfoDoctorTableCell.identifier)
        doctorDetailTableView.register(SpecializationTableCell.self, forCellReuseIdentifier: SpecializationTableCell.identifier)
        doctorDetailTableView.register(UINib(nibName: "StarTableCell", bundle: nil), forCellReuseIdentifier: StarTableCell.identifier)
        doctorDetailTableView.register(ReviewTagTableCell.self, forCellReuseIdentifier: ReviewTagTableCell.identifier)
        self.view.addSubview(doctorDetailTableView)
        
        if #available(iOS 15.0, *) {
            doctorDetailTableView.sectionHeaderTopPadding = 0
        }
    }
    
    /// set text di previousPriceLabel dan priceLabel
    func setPrice(){
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: "Rp." + (doctorDetail?.previousPrice ?? ""))
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributedString.length))
        previousPriceLabel.attributedText = attributedString
        priceLabel.text = "Rp." + (doctorDetail?.price ?? "Undefined")
    }
}

extension DoctorDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch DoctorDetailSection(section){
        case .header, .specialization, .reviewTag, .reviewStar:
            return 1
        case .info:
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch DoctorDetailSection(indexPath.section){
        case .header:
            guard let cell = doctorDetailTableView.dequeueReusableCell(withIdentifier: HeaderDoctorTableCell.identifier, for: indexPath) as? HeaderDoctorTableCell else { return UITableViewCell() }
            cell.setData(doctor: doctorDetail)
            return cell
            
        case .info:
            guard let cell = doctorDetailTableView.dequeueReusableCell(withIdentifier: InfoDoctorTableCell.identifier, for: indexPath) as? InfoDoctorTableCell else { return UITableViewCell() }
            
            /// set data spesialis
            if indexPath.row == 0 {
                cell.setDataSpesialis(doctorSpes: doctorDetail?.specialization ?? "")
            /// set data location
            } else if indexPath.row == 1 {
                cell.setDataLoc(doctorLoc: doctorDetail?.location ?? "")
            }
                
            return cell
            
        case .specialization:
            guard let cell = doctorDetailTableView.dequeueReusableCell(withIdentifier: SpecializationTableCell.identifier, for: indexPath) as? SpecializationTableCell else { return UITableViewCell() }
            cell.setSpecCell()
            cell.specializationLabel.text = doctorDetail?.specializationDetail
            return cell
            
        case .reviewStar:
            guard let cell = doctorDetailTableView.dequeueReusableCell(withIdentifier: StarTableCell.identifier, for: indexPath) as? StarTableCell else { return UITableViewCell() }
            cell.ratingLabel.text = doctorDetail?.rating
            return cell
            
        case .reviewTag:
            guard let cell = doctorDetailTableView.dequeueReusableCell(withIdentifier: ReviewTagTableCell.identifier, for: indexPath) as? ReviewTagTableCell else { return UITableViewCell() }
            cell.doctorDetail = doctorDetail
            cell.setColViewDelegate()
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch DoctorDetailSection(section) {
        case .header, .reviewTag, .reviewStar:
            return nil
        case .info:
            let headerView = UITableViewHeaderFooterView()
            let cornerView = UIView()
            cornerView.clipsToBounds = true
            cornerView.layer.cornerRadius = 20
            cornerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            cornerView.backgroundColor = .white
            cornerView.translatesAutoresizingMaskIntoConstraints = false
            
            headerView.addSubview(cornerView)
            
            NSLayoutConstraint.activate([
                cornerView.topAnchor.constraint(equalTo: headerView.topAnchor),
                cornerView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
                cornerView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
                cornerView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor)
            ])
            return headerView
            
        case .specialization:
            let headerView = UITableViewHeaderFooterView()
            
            let bgView = UIView()
            bgView.translatesAutoresizingMaskIntoConstraints = false
            bgView.backgroundColor = .white
            
            let specTitleLabel: UILabel = {
                let specTitle = UILabel()
                specTitle.text = "Spesialisasi"
                specTitle.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
                specTitle.translatesAutoresizingMaskIntoConstraints = false
                return specTitle
            }()
            
            headerView.addSubview(bgView)
            bgView.addSubview(specTitleLabel)
            
            NSLayoutConstraint.activate([
                bgView.topAnchor.constraint(equalTo: headerView.topAnchor),
                bgView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
                bgView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
                bgView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
                specTitleLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 20),
                specTitleLabel.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -5),
                specTitleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 20),
                specTitleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -20)
            ])
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch DoctorDetailSection(section) {
        case .header, .reviewTag, .reviewStar:
            return 0
        case .info:
            return 20
        case .specialization:
            return 50
        }
    }
}
