//
//  ChatMessageMapper.swift
//  MC3
//
//  Created by Wahyu Alfandi on 24/07/23.
//

import Foundation
final class OpenAIAnswerMapper {
    static func mapOpenAIResponseToAnswer(input response: OpenAIResponse) -> OpenAIAnswer {
        guard let textResponse = response.choices.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines.union(.init(charactersIn: "\""))) else {return .sharedExample}
        
        return OpenAIAnswer(
            id: response.id ?? "",
            content: textResponse ,
            createdDate: Date()
        )
    }
}
