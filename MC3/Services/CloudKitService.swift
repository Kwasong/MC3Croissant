//
//  CloudKitService.swift
//  MC3
//
//  Created by Safik Widiantoro on 30/07/23.
//

import Foundation
import CloudKit

class CloudKitService {
    private let container: CKContainer
    private let database: CKDatabase

    init() {
        container = CKContainer(identifier: "iCloud.com.kwasong.MC3")
        database = container.publicCloudDatabase
    }
    
    func fetchApiKeyData(apiType: APIType) async throws -> String {
        print("[CloudKitService][fetchApiKeyData][apiType]", apiType)
        let predicate = NSPredicate(format: "name == %@", apiType.rawValue) // Fetch records where fieldName matches fieldValue
        let query = CKQuery(recordType: "API_Key", predicate: predicate)
        let result = try await fetchData(query: query, resultsLimit: 1)
        print("[CloudKitService][fetchApiKeyData][result]", result)
        
        let data = result.matchResults
            .compactMap { _, result in try? result.get() }
            .compactMap{ $0["key"] as? String }
        print("[CloudKitService][fetchApiKeyData][data]", data)
        
        guard let apiKey = data.first else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "API Key not found"])
        }
        
        return apiKey
    }
    
    func fetchData(query: CKQuery, resultsLimit: Int = 0) async throws -> (matchResults: [(CKRecord.ID, Result<CKRecord, any Error>)], queryCursor: CKQueryOperation.Cursor?) {
        print("[CloudKitService][fetchData][query]", query)
        let result = try await database.records(matching: query, inZoneWith: .default, resultsLimit: resultsLimit)
        print("[CloudKitService][fetchData][result]", result)
        return result
    }
}

/*
 private let container: CKContainer
     private let database: CKDatabase

     init() {
         container = CKContainer(identifier: "iCloud.com.Vincent-Gunawan.MC3")
         database = container.publicCloudDatabase
     }
     
     func fetchApiKeyData(apiType: APIType) async throws -> String {
         print("[CloudKitService][fetchApiKeyData][apiType]", apiType)
         let predicate = NSPredicate(format: "name == %@", apiType.rawValue) // Fetch records where fieldName matches fieldValue
         let query = CKQuery(recordType: "API_Key", predicate: predicate)
         let result = try await fetchData(query: query, resultsLimit: 1)
         print("[CloudKitService][fetchApiKeyData][result]", result)
         
         let data = result.matchResults
             .compactMap { _, result in try? result.get() }
             .compactMap{ $0["apiKey"] as? String }
         print("[CloudKitService][fetchApiKeyData][data]", data)
         
         guard let apiKey = data.first else {
             throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"])
         }
         
         return apiKey
     }
     
     func fetchData(query: CKQuery, resultsLimit: Int = 0) async throws -> (matchResults: [(CKRecord.ID, Result<CKRecord, any Error>)], queryCursor: CKQueryOperation.Cursor?) {
         print("[CloudKitService][fetchData][query]", query)
         let result = try await database.records(matching: query, inZoneWith: .default, resultsLimit: resultsLimit)
         print("[CloudKitService][fetchData][result]", result)
         return result
     }
     
     func fetchData(recordID: CKRecord.ID) async throws -> CKRecord {
         print("[CloudKitService][fetchData][recordID]", recordID)
         let result = try await database.record(for: recordID)
         print("[CloudKitService][fetchData][result]", result)
         return result
     }
     
     func saveData(record: CKRecord) async throws -> CKRecord {
         return try await database.save(record)
     }
 */
