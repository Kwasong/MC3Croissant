//
//  OpenAIRequest.swift
//  MC3
//
//  Created by Wahyu Alfandi on 24/07/23.
//

import Foundation



struct OpenAIRequest: Encodable {
    let model: String
    let prompt: String
    let temperature: Float?
    let max_tokens: Int
    
    init(model: String = "text-davinci-003", prompt: String, temperature: Float = 0.5, max_tokens: Int = 256) {
        self.model = model
        self.prompt = prompt
        self.temperature = temperature
        self.max_tokens = max_tokens
    }
}


