//
//  GhoneUseCase.swift
//  MC3
//
//  Created by Wahyu Alfandi on 21/08/23.
//

import Foundation

protocol GhoneUseCaseProtocol {
    func sendMessage(text: String) async -> Result<OpenAIAnswer, Error>
    func fetchTextToSpeech(text: String) async -> Result<Data, Error>
}

class GhoneUseCase {
    private let repository: GhoneRepositoryProtocol
    
    init(repository: GhoneRepositoryProtocol) {
        self.repository = repository
    }
}

extension GhoneUseCase: GhoneUseCaseProtocol {
   
    func sendMessage(text: String) async -> Result<OpenAIAnswer, Error>  {
        let request = OpenAIRequest(prompt: text)
        do {
            let data = try await self.repository.sendMessage(params: request)
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
    
    func fetchTextToSpeech(text: String) async -> Result<Data, Error> {
        do {
            let data = try await self.repository.fetchTextToSpeech(text: text)
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
    
}
