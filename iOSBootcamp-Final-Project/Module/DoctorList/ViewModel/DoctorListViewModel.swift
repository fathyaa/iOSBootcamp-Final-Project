//
//  DoctorListViewModel.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 03/05/23.
//

import Foundation

protocol DoctorListViewProtocol {
    var urlString: String { get }
    var bindDoctorsData: (([Doctors]?) -> ())? { get set}
    func fetchDoctorsData()
}

class DoctorListViewModel: DoctorListViewProtocol {
    private var apiService: ApiServiceProtocol?
    var urlString: String
    var doctorsModel: Doctors?
    
    /// untuk mereferensi ke closure tersebut. digunakan buat callback di VC
    var bindDoctorsData: (([Doctors]?) -> Void)?
    
    init(urlString: String, apiService: ApiServiceProtocol){
        self.urlString = urlString
        self.apiService = apiService
        if let url = URL(string: urlString){
            self.apiService?.get(url: url)
        }
        /// panggil function untuk ambil data dari api
        fetchDoctorsData()
    }
    
    func fetchDoctorsData() {
        self.apiService?.callApi(model: [Doctors].self, completion: { response in
            switch response {
            case .success(let doctorsData):
                /// data yang difetch diikat di bindDoctorData
                self.bindDoctorsData?(doctorsData)
            case .failure(let error):
                print(error.localizedDescription)
                self.bindDoctorsData?(nil)
            }
        })
    }
}
