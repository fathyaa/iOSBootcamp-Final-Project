//
//  ApiService.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 06/04/23.
//

import Foundation

/// buat protocol untuk abstraction
protocol ApiServiceProtocol {
    /// untuk nampung url
    mutating func get(url: URL)
    /// function untuk handle networking
    func callApi<T: Codable>(model: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

/// implementasi protocol
struct ApiService: ApiServiceProtocol {
    private var url = URL(string: "")
    
    /// masukkan url dari parameter ke self.url
    mutating func get(url: URL) {
        self.url = url
    }
    
    func callApi<T>(model: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        /// jagain kalau urlnya gak ada, func callApi-nya berhenti
        guard let url = self.url else { return }
        /// buat UrlSession untuk handle api
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let fetchedData = data {
                do {
                    /// bikin decoder, masukin data ke model lewat completion
                    let modelData = try JSONDecoder().decode(T.self, from: fetchedData)
                    return completion(.success(modelData))
                /// handle kalau parsing datanya eror
                } catch let error {
                    print("decode fail")
                    return completion(.failure(error))
                }
            }
        /// resume task
        }.resume()
    }
}
