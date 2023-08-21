//
//  ElevenLabDataSourceProtocol.swift
//  MC3
//
//  Created by Wahyu Alfandi on 21/08/23.
//

import Foundation

protocol ElevenLabDataSourceProtocol {
    func fetchTextToSpeech(text: String) async throws -> Data
}

class ElevenLabDataSource{
    private let cloudKit: CloudKitDataSource?
    
    private init(cloudKit: CloudKitDataSource?) {
        self.cloudKit = cloudKit
    }
    
    static let sharedInstance: (CloudKitDataSource?) -> ElevenLabDataSource = { cloudKit in
        return ElevenLabDataSource(cloudKit: cloudKit)
    }
    
}

extension ElevenLabDataSource: ElevenLabDataSourceProtocol {
    func fetchTextToSpeech(text: String) async throws -> Data {
        guard let cloudKit = self.cloudKit else {throw DatabaseError.invalidInstance}
        let apiKey = try await cloudKit.fetchApiKeyData(apiType: .elevenLabs)
        
        guard let url = URL(string: Endpoints.Gets.textToSpeech.url) else { throw URLError.invalidURL }
        
        let json: [String: Any] = [
            "text": text,
            "voice_settings": [
                "stability": 0.5,
                "similarity_boost": 0.75
            ]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("audio/mpeg", forHTTPHeaderField: "accept")
        request.setValue(apiKey, forHTTPHeaderField: "xi-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw URLError.invalidResponse
        }
        
        return data
    }
}

//extension ElevenLabsService{
//    
//    func fetchTextToSpeech(text: String) async throws -> Data{
//        let cloudKitService: CloudKitService = CloudKitService()
//        let apiKey = try await cloudKitService.fetchApiKeyData(apiType: .elevenLabs)
//        print("[fetchTextToSpeech][apiKey]", apiKey)
//        
//        guard let url =  URL(string: Endpoints.Gets.textToSpeech.url) else {
//            print("url salah")
//            throw URLError.invalidURL
//        }
//        
//        let json: [String: Any] = [
//            "text": text,
//            "model_id": "eleven_monolingual_v1",
//            "voice_settings": [
//                "stability": 0.5,
//                "similarity_boost": 0.75
//            ]
//        ]
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpBody = jsonData
//        request.setValue("audio/mpeg", forHTTPHeaderField: "accept")
//        request.setValue(apiKey, forHTTPHeaderField: "xi-api-key")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        let (data, response) = try await URLSession.shared.data(for: request)
//        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//            throw URLError.invalidResponse
//        }
//        
//        return data
//    }
//    
//    
//    func fetchTextToSpeech(text: String, result: @escaping(Result<Data, URLError>) -> Void){
//        guard let apiKey: String = Bundle.main.infoDictionary?["EL_API_KEY"] as? String else {return}
//        
//        
//        guard let url =  URL(string: Endpoints.Gets.textToSpeech.url) else {
//            print("url salah")
//            return
//        }
//        
//        let json: [String: Any] = [
//            "text": text,
//            "model_id": "eleven_monolingual_v1",
//            "voice_settings": [
//                "stability": 0.5,
//                "similarity_boost": 0.75
//            ]
//        ]
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("audio/mpeg", forHTTPHeaderField: "accept")
//        request.setValue(apiKey, forHTTPHeaderField: "xi-api-key")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
//        
//        let task = session.uploadTask(with: request, from: jsonData){ maybeData, maybeResponse, error in
//            if error != nil {
//                result(.failure(.addressUnreachable(url)))
//            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
//                print(data)
//                result(.success(data))
//            } else if let response = maybeResponse as? HTTPURLResponse, response.statusCode == 400 {
//                result(.failure(.noDataFound))
//            }
//            else if let response = maybeResponse as? HTTPURLResponse, response.statusCode == 401{
//                result(.failure(.unAuthorized))
//            }
//            
//        }
//        task.resume()
//    }
//}
