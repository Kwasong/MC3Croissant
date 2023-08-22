//
//  APICall.swift
//  MC3
//
//  Created by Wahyu Alfandi on 24/07/23.
//


import Foundation

enum API {
    static let gptURL = "https://api.openai.com/v1/"
    static let elevenLabsURL = "https://api.elevenlabs.io/v1/"
}

protocol Endpoint {
    var url: String {get}
}

enum Endpoints {
    
    enum Gets: Endpoint {
        case completion
        case textToSpeech
        
        public var url: String {
            switch self {
            case .completion: return "\(API.gptURL)completions"
            case .textToSpeech: return "\(API.elevenLabsURL)text-to-speech/MF3mGyEYCl7XYWbV9V6O"
            
            }
        }
    }
    
}
