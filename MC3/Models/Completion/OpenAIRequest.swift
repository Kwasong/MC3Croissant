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
}


