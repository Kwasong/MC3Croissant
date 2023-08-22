//
//  OpenAIResponse.swift
//  MC3
//
//  Created by Wahyu Alfandi on 24/07/23.
//

import Foundation

struct OpenAIResponse : Decodable{
    let id: String?
    let choices: [OpenAIResponseChoice]
}

struct OpenAIResponseChoice: Decodable{
    let index: Int?
    let text: String?
}
