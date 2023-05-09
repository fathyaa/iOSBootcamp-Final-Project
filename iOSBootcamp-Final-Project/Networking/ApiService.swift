//
//  ApiService.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 06/04/23.
//

import Foundation

/// buat protocol untuk abstraction
protocol ApiServiceProtocol {
    mutating func get(url: URL)
    func callApi<T: Codable>(model: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

/// implementasi protocol
struct ApiService: ApiServiceProtocol {
    private var url = URL(string: "")
    mutating func get(url: URL) {
        self.url = url
    }
    
    func callApi<T>(model: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        guard let url = self.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let fetchedData = data {
                do {
                    let modelData = try JSONDecoder().decode(T.self, from: fetchedData)
                    return completion(.success(modelData))
                } catch let error {
                    print("decode fail")
                    return completion(.failure(error))
                }
            }
        }.resume()
    }
}
