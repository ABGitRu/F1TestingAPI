//
//  NetworkService.swift
//  F1TestingAPI
//
//  Created by Mac on 24.05.2021.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    var delegate: UpdatesDelegate?
    
    func fetchData<T: Codable>(expectedType: T.Type, url: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let urlData = URL(string: url) else { return }
        URLSession.shared.dataTask(with: urlData) { (data, _, error) in
            guard let data = data, error == nil else { return }
            
            var decodedResult: T?
            
            do {
                 decodedResult = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    self.delegate?.didFinishUpdates(finished: true)
                }
            } catch {
                print(error)
            }
            
            guard let result = decodedResult else { return }
            
            completion(.success(result))
        }.resume()
    }
}
