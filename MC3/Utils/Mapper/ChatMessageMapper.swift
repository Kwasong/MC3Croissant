//
//  ChatMessageMapper.swift
//  MC3
//
//  Created by Wahyu Alfandi on 24/07/23.
//

import Foundation
final class ChatMessageMapper {
    static func mapOpenAIResponseToChatMessage(input response: OpenAIResponse) -> ChatMessage {
        guard let textResponse = response.choices.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines.union(.init(charactersIn: "\""))) else {return .sharedExample}
        
        return ChatMessage(
            id: response.id ?? "",
            content: textResponse ,
            createdDate: Date()
        )
    }
}
