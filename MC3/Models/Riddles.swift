//
//  Riddles.swift
//  MC3
//
//  Created by Sha Nia Siahaan on 25/07/23.
//

import Foundation

struct RiddlesModel {
    let id: UUID = UUID()
    let question: String?
    let answer: String?
}
extension RiddlesModel {
    static var mockRiddles = [
        RiddlesModel(
            question: "What did the ocean say to the beach?",
            answer: "Nothing, it just waved"
        ),
        RiddlesModel(
            question: "Where do fruits go on vacation?",
            answer: "Pear-is!"
        ),
    ]
}
