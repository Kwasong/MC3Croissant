//
//  ChatMessage.swift
//  MC3
//
//  Created by Wahyu Alfandi on 24/07/23.
//

import Foundation

struct ChatMessage: Identifiable{
    let id: String?
    let content: String?
    let createdDate: Date
}


extension ChatMessage {
    static var sharedExample = ChatMessage(id: "", content: "", createdDate: Date())
}
