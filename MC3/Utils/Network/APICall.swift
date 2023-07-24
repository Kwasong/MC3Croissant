//
//  APICall.swift
//  MC3
//
//  Created by Wahyu Alfandi on 24/07/23.
//


import Foundation

struct API {
    static let gptURL = "https://api.openai.com/v1/"
    static let elevenLabsURL = "https://3.1.211.225/api/v1/"
}

protocol Endpoint {
    var url: String {get}
}
enum Endpoints {
    
    enum Gets: Endpoint {
        case completion
        case speech
        
        public var url: String {
            switch self {
            case .completion: return "\(API.gptURL)completions"
            case .speech: return "\(API.elevenLabsURL)user"
            
            }
        }
    }
    
}
