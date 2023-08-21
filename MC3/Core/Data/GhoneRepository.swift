//
//  GhoneRepository.swift
//  MC3
//
//  Created by Wahyu Alfandi on 21/08/23.
//

import Foundation

protocol GhoneRepositoryProtocol {
    func fetchTextToSpeech(text: String) async throws -> Data
    func sendMessage(params: OpenAIRequest) async throws -> OpenAIAnswer
}

class GhoneRepository {
    fileprivate let remote: RemoteDataSource
    
    private init(remote: RemoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: (RemoteDataSource) -> GhoneRepository = { remoteRepo in
        return GhoneRepository(remote: remoteRepo)
    }
    
}

extension GhoneRepository: GhoneRepositoryProtocol {
    func fetchTextToSpeech(text: String) async throws -> Data {
        let response = try await self.remote.fetchTextToSpeech(text: text)
        return response
    }
    
    func sendMessage(params: OpenAIRequest) async throws -> OpenAIAnswer {
        let response = try await self.remote.sendMessage(params: params)
        let answer = OpenAIAnswerMapper.mapOpenAIResponseToAnswer(input: response)
        
        return answer
    }
}
