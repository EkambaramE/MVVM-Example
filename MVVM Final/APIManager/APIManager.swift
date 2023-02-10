//
//  APIManager.swift
//  MVVM Final
//
//  Created by Ekambaram E on 12/14/22.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case responseFailed
}


protocol APIManagerProtocol {
    
    func fetch<T: Codable>(urlString: String, model: T.Type, completion: @escaping (Result<Any, Error>) -> Void)
}

class APIManager: APIManagerProtocol {
    
    func fetch<T: Codable>(urlString: String, model: T.Type, completion: @escaping (Result<Any, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data else {
                completion(.failure(APIError.responseFailed))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}


