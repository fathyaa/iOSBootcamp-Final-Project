//
//  HomeViewModel.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 10/04/23.
//

import Foundation

protocol HomeViewProtocol {
    var urlString: String { get } /// untuk nampung url
    var bindHomeData: (([Home]?) -> ())? { get set}
    func fetchHomeData()
}

/// implement protocol
class HomeViewModel: HomeViewProtocol {
    private var apiService: ApiServiceProtocol?
    var urlString: String
    var homeModel: Home?

    /// untuk mereferensi ke closure tersebut. digunakan buat callback di VC
    var bindHomeData: (([Home]?) -> Void)?
    
    /// inisialisasi properties yang dibutuhkan
    init(urlString: String, apiService: ApiServiceProtocol){
        self.urlString = urlString
        self.apiService = apiService
        if let url = URL(string: urlString){
            self.apiService?.get(url: url)
        }
        /// panggil function untuk ambil data dari api
        fetchHomeData()
    }
    
    // MARK: - Fetch data from API
    func fetchHomeData() {
        self.apiService?.callApi(model: [Home].self, completion: { response in
            switch response {
            case .success(let homeData):
                /// data yang difetch diikat di bindHomeData
                self.bindHomeData?(homeData)
            case .failure(let error):
                print(error.localizedDescription)
                self.bindHomeData?(nil)
            }
        })
    }
}
