//
//  ChatMessage.swift
//  MC3
//
//  Created by Wahyu Alfandi on 24/07/23.
//

import Foundation

struct OpenAIAnswer: Identifiable{
    let id: String?
    let content: String?
    let createdDate: Date
}

extension OpenAIAnswer {
    static var sharedExample = OpenAIAnswer(id: "", content: "", createdDate: Date())
}
