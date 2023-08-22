//
//  CloudKitService.swift
//  MC3
//
//  Created by Safik Widiantoro on 30/07/23.
//

import Foundation
import CloudKit

protocol APIKeyProvider {
    func fetchApiKeyData(apiType: APIType) async throws -> String
}

class CloudKitDataSource {
    private let container: CKContainer
    private let database: CKDatabase

    private init() {
        container = CKContainer(identifier: "iCloud.com.kwasong.MC3")
        database = container.publicCloudDatabase
    }
    
    static let sharedInstance: () -> CloudKitDataSource = { 
        return CloudKitDataSource()
    }
}

extension CloudKitDataSource: APIKeyProvider {
    func fetchApiKeyData(apiType: APIType) async throws -> String {
        let predicate = NSPredicate(format: "name == %@", apiType.rawValue)
        let query = CKQuery(recordType: "API_Key", predicate: predicate)
        let result = try await fetchData(query: query, resultsLimit: 1)
        
        let data = result.matchResults
            .compactMap { _, result in try? result.get() }
            .compactMap{ $0["key"] as? String }
        
        guard let apiKey = data.first else {
            throw URLError.invalidAPIKey
        }
        
        return apiKey
    }
    
    private func fetchData(query: CKQuery, resultsLimit: Int = 0) async throws -> (matchResults: [(CKRecord.ID, Result<CKRecord, any Error>)], queryCursor: CKQueryOperation.Cursor?) {
        let result = try await database.records(matching: query, inZoneWith: .default, resultsLimit: resultsLimit)
        return result
    }
}

class XCConfigDataSource{
    private init() {}
    
    static let sharedInstance: () -> XCConfigDataSource = {
        return XCConfigDataSource()
    }
}

extension XCConfigDataSource: APIKeyProvider {
    func fetchApiKeyData(apiType: APIType) async throws -> String {
        switch apiType {
            case .chatGPT:
                guard let apiKey: String = Bundle.main.infoDictionary?["GPT_API_KEY"] as? String else {
                    throw URLError.noDataFound
                }
                
                return apiKey
            case .elevenLabs:
                guard let apiKey: String = Bundle.main.infoDictionary?["EL_API_KEY"] as? String else {
                    throw URLError.noDataFound
                }
                return apiKey
        }
    }
}


