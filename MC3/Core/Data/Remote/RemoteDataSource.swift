//
//  RemoteDataSources.swift
//  MC3
//
//  Created by Wahyu Alfandi on 21/08/23.
//

import Foundation

protocol RemoteDataSourceProtocol {
    func fetchTextToSpeech(text: String) async throws -> Data
    func sendMessage(params: OpenAIRequest) async throws -> OpenAIResponse
    
}

final class RemoteDataSource {
    
    private let cloudKiDataSource: CloudKitDataSourceProtocol?
    private let openAIDataSource: OpenAIDataSourceProtocol?
    private let elevenLabDataSource: ElevenLabDataSourceProtocol?
    
    private init(cloudKiDataSource: CloudKitDataSourceProtocol, openAIDataSource: OpenAIDataSourceProtocol, elevenLabDataSource: ElevenLabDataSourceProtocol) {
        self.cloudKiDataSource = cloudKiDataSource
        self.openAIDataSource = openAIDataSource
        self.elevenLabDataSource = elevenLabDataSource
    }
    
    static let sharedInstance: (CloudKitDataSourceProtocol, OpenAIDataSourceProtocol, ElevenLabDataSourceProtocol) -> RemoteDataSource = { cloudKit, openAI, elevenLab in
        return RemoteDataSource(cloudKiDataSource: cloudKit, openAIDataSource: openAI, elevenLabDataSource: elevenLab)
        
    }
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func fetchTextToSpeech(text: String) async throws -> Data {
        do {
            if let result = try await elevenLabDataSource?.fetchTextToSpeech(text: text){
                return result
            }else {
                throw URLError.unknownError
            }
        } catch {
            throw error
        }
    }
    
    func sendMessage(params: OpenAIRequest) async throws -> OpenAIResponse {
        do {
            if let result = try await openAIDataSource?.sendMessage(params: params){
                return result
            } else {
                throw URLError.unknownError
            }
        } catch {
            throw error
        }
    }
    
    
    
    
}
