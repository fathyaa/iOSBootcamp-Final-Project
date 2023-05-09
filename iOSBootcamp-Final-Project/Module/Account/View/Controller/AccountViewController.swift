//
//  AccountViewController.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 10/04/23.
//

import UIKit

/// enum untuk menamakan index section di accounttableview
enum AccountSection {
    case profile
    case menuSettings
    case menuHelps
    
    init(_ section: Int){
        switch section {
        case 0:
            self = .profile
        case 1:
            self = .menuSettings
        case 2:
            self = .menuHelps
        default:
            self = .menuSettings
        }
    }
}

class AccountViewController: UIViewController {

    @IBOutlet weak var accountTableView: UITableView!
    var modelAccount: [Account]?
    var accountViewModel: AccountViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAccountTableView()
        bindAPIData()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogout))
    }
    
    func setAccountTableView() {
        accountTableView.delegate = self
        accountTableView.dataSource = self
        accountTableView.separatorStyle = .none
        accountTableView.register(UINib(nibName: "ProfileTableCell", bundle: nil), forCellReuseIdentifier: ProfileTableCell.identifier)
        accountTableView.register(UINib(nibName: "MenuTableCell", bundle: nil), forCellReuseIdentifier: MenuTableCell.identifier)
        
        accountTableView.sectionFooterHeight = 0.0
        // atur padding atas
        self.accountTableView.contentInset = UIEdgeInsets(top: -35, left: 0, bottom: 0, right: 0);
    }
    
    /// func untuk bind data dari API, lalu dimasukkan ke modelAccount
    func bindAPIData() {
        self.accountViewModel = AccountViewModel(urlString: "http://localhost:3003/account", apiService: ApiService())
        self.accountViewModel?.bindAccountData = { accountData in
            if let modelData = accountData {
                self.modelAccount = modelData
            } else {
                self.accountTableView.backgroundColor = .red
            }
            print("reload data")
            DispatchQueue.main.async {
                self.accountTableView.reloadData()
            }
        }
    }
    
    /// function yang di dalamnya actions ketika logoutButton ditekan
    @objc private func didTapLogout() {
        AuthService.shared.logoutUser { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogoutError(on: self, with: error)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
}

extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch AccountSection(section){
        case .profile:
            return 1
        case .menuSettings:
            return 3
        case .menuHelps:
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch AccountSection(indexPath.section){
        case .profile:
            guard let cell = accountTableView.dequeueReusableCell(withIdentifier: ProfileTableCell.identifier, for: indexPath) as? ProfileTableCell else { return UITableViewCell() }
            cell.fetchUserInProfile()
            cell.backgroundColor = .clear
            return cell
        case .menuSettings, .menuHelps:
            guard let cell = accountTableView.dequeueReusableCell(withIdentifier: MenuTableCell.identifier, for: indexPath) as? MenuTableCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            if let accountData = modelAccount?[indexPath.section - 1] {
                cell.setData(menuItems: accountData.items[indexPath.row])
            }
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    // atur header dan footer agar view di ujung sectionnya rounded
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch AccountSection(section) {
        case .profile:
            return nil
        case .menuSettings, .menuHelps:
            let headerView = UITableViewHeaderFooterView()
            let roundedView = UIView()
            roundedView.translatesAutoresizingMaskIntoConstraints = false
            roundedView.backgroundColor = .white
            roundedView.layer.cornerRadius = 20
            roundedView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            
            headerView.addSubview(roundedView)
            
            NSLayoutConstraint.activate([
                roundedView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 5),
                roundedView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
                roundedView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 13.5),
                roundedView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -13.7)
            ])
            
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch AccountSection(section){
        case .profile:
            return 0
        case .menuSettings, .menuHelps:
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch AccountSection(section) {
        case .profile:
            return nil
        case .menuSettings, .menuHelps:
            let headerView = UITableViewHeaderFooterView()
            let roundedView = UIView()
            roundedView.translatesAutoresizingMaskIntoConstraints = false
            roundedView.backgroundColor = .white
            roundedView.layer.cornerRadius = 20
            roundedView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            
            headerView.addSubview(roundedView)
            
            NSLayoutConstraint.activate([
                roundedView.topAnchor.constraint(equalTo: headerView.topAnchor),
                roundedView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -5),
                roundedView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 13.2),
                roundedView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -13.2)
            ])
            
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch AccountSection(section){
        case .profile:
            return 0
        case .menuSettings, .menuHelps:
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
