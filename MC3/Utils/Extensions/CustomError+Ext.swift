//
//  CustomError.swift
//  MC3
//
//  Created by Wahyu Alfandi on 24/07/23.
//

import Foundation

enum URLError: LocalizedError {
    case invalidURL
    case invalidResponse
    case addressUnreachable(URL)
    case noDataFound
    case authenticationFailed
    case requestTimeout
    case serverError
    case unAuthorized
    case unknownError
    case tooManyRequest
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL."
        case .invalidResponse: return "The server responded with garbage."
        case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
        case .noDataFound: return "No data was found."
        case .authenticationFailed: return "Authentication failed."
        case .requestTimeout: return "The request timed out."
        case .serverError: return "The server encountered an error."
        case .unAuthorized: return "The request is unauthorized"
        case .unknownError: return "An unknown error occurred."
        case .tooManyRequest: return "Too many request, please try again in 20s"
        }
    }
    
}
