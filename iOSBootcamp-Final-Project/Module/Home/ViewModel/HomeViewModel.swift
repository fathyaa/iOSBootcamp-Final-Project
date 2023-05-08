//
//  HomeViewModel.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 10/04/23.
//

import Foundation

protocol HomeViewProtocol {
    var urlString: String { get }
    var bindHomeData: (([Home]?) -> ())? { get set}
    func fetchHomeData()
}

class HomeViewModel: HomeViewProtocol {
    private var apiService: ApiServiceProtocol?
    var urlString: String
    var homeModel: Home?

    var bindHomeData: (([Home]?) -> Void)?
    
    init(urlString: String, apiService: ApiServiceProtocol){
        self.urlString = urlString
        self.apiService = apiService
        if let url = URL(string: urlString){
            self.apiService?.get(url: url)
        }
        fetchHomeData()
    }
    
    func fetchHomeData() {
        self.apiService?.callApi(model: [Home].self, completion: { response in
            switch response {
            case .success(let success):
                self.bindHomeData?(success)
            case .failure(let error):
                print(error.localizedDescription)
                self.bindHomeData?(nil)
            }
        })
    }
}
