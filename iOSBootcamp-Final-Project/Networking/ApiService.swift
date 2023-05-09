//
//  ApiService.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 06/04/23.
//

import Foundation

/// protocol untuk abstraction
protocol ApiServiceProtocol {
    mutating func get(url: URL)
    func callApi<T: Codable>(model: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

struct ApiService: ApiServiceProtocol {
    private var url = URL(string: "")
    
    /// func untuk masukkan url dari parameter ke self.url
    mutating func get(url: URL) {
        self.url = url
    }
    
    ///function untuk handle networking
    func callApi<T>(model: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        // jagain kalau urlnya gak ada, func callApi-nya berhenti
        guard let url = self.url else { return }
        // buat UrlSession untuk handle api
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let fetchedData = data {
                do {
                    // bikin decoder, masukin data ke model lewat completion
                    let modelData = try JSONDecoder().decode(T.self, from: fetchedData)
                    return completion(.success(modelData))
                // handle kalau parsing datanya eror
                } catch let error {
                    print("decode fail")
                    return completion(.failure(error))
                }
            }
        }.resume()
    }
}
