//
//  UserError.swift
//  ClosureToAsyncAwait
//
//  Created by Ayush Gupta on 09/04/24.
//

import Foundation

enum UserError: LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidData
    case dynamicError(error: Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
            
        case .invalidResponse:
            return "Invalid Response"
            
        case .invalidData:
            return "Invalid data"
            
        case .dynamicError(error: let error):
            return error.localizedDescription
        }
    }
}
