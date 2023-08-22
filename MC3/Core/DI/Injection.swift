//
//  Injection.swift
//  MC3
//
//  Created by Wahyu Alfandi on 21/08/23.
//

import Foundation

final class Injection: NSObject {
    
    private func provideCloudKitDataSource() -> CloudKitDataSource {
        let cloudKit = CloudKitDataSource.sharedInstance()
        return cloudKit
    }
    
    private func provideXCConfigDataSource() -> XCConfigDataSource {
        let config = XCConfigDataSource.sharedInstance()
        return config
    }
    
    private func provideOpenAIDataSource() -> OpenAIDataSource {
        let openAI = OpenAIDataSource.sharedInstance(provideXCConfigDataSource())
        return openAI
    }
    
    private func provideElevenLabDataSource() -> ElevenLabDataSource {
        let elevenLab = ElevenLabDataSource.sharedInstance(provideXCConfigDataSource())
        return elevenLab
    }
    
    func provideGhoneRepository() -> GhoneRepository {
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance(provideOpenAIDataSource(), provideElevenLabDataSource())
        
        return GhoneRepository.sharedInstance(remote)
    }
    
    func provideGhoneUseCase() -> GhoneUseCaseProtocol {
        let useCase = GhoneUseCase(repository: provideGhoneRepository())
        return useCase
    }
    
    
}
