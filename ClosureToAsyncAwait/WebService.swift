//
//  WebService.swift
//  ClosureToAsyncAwait
//
//  Created by Ayush Gupta on 09/04/24.
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
            if let error {
                completion([], UserError.description(error: error))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                completion([], UserError.invalidResponse)
                return
            }
            
            guard let data else {
                completion([], UserError.invalidData)
                return
            }
            
            do {
                let result = try JSONDecoder().decode([UserModel].self, from: data)
                completion(result, nil)
            } catch(let err) {
                completion([], UserError.description(error: err))
            }
        }
        task.resume()
    }
}
