//
//  AccountViewModel.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 10/04/23.
//

import Foundation

protocol AccountViewProtocol {
    var urlString: String { get }
    var bindAccountData: (([Account]?) -> ())? { get set}
    func fetchAccountData()
}

/// implement protocol
class AccountViewModel: AccountViewProtocol {
    private var apiService: ApiServiceProtocol?
    var urlString: String
    var doctorsModel: Account?
    
    /// untuk mereferensi ke closure tersebut. digunakan buat callback di VC
    var bindAccountData: (([Account]?) -> Void)?
    
    init(urlString: String, apiService: ApiServiceProtocol){
        self.urlString = urlString
        self.apiService = apiService
        if let url = URL(string: urlString){
            self.apiService?.get(url: url)
        }
        fetchAccountData()
    }
    
    func fetchAccountData() {
        self.apiService?.callApi(model: [Account].self, completion: { response in
            switch response {
            case .success(let accountData):
                /// data yang difetch diikat di bindAccountData
                self.bindAccountData?(accountData)
            case .failure(let error):
                print(error.localizedDescription)
                self.bindAccountData?(nil)
            }
        })
    }
}
