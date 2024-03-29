//
//  WebService.swift
//  ClosureToAsyncAwait
//
//  Created by Ayush Gupta on 06/01/24.
//

import Foundation

final class WebService {
    
    // MARK: API call Using closure (escaping closure)
    
    static func fetchUserData(completion: @escaping ([UserModel], UserError?) -> Void) {
        let urlString = "https://api.github.com/users"
        guard let url = URL(string: urlString) else {
            completion([], UserError.invalidURL)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                completion([], UserError.invalidResponse)
                return
            }
            
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([UserModel].self, from: data)
                    completion(result, nil)
                } else {
                    completion([], UserError.invalidData)
                }
            } catch {
                completion([], UserError.invalidData)
            }
        }
        task.resume()
    }
}

enum UserError: LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
            
        case .invalidResponse:
            return "Invalid Response"
            
        case .invalidData:
            return "Invalid data"
        }
    }
}
