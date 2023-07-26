//
//  ElevenLabService.swift
//  MC3
//
//  Created by Wahyu Alfandi on 24/07/23.
//

import Foundation

class ElevenLabsService: NSObject, URLSessionDelegate{
    private override init() {}
    static let sharedInstance: ElevenLabsService = ElevenLabsService()
}

extension ElevenLabsService{
    func fetchTextToSpeech(text: String, result: @escaping(Result<Data, URLError>) -> Void){
        guard let apiKey: String = Bundle.main.infoDictionary?["EL_API_KEY"] as? String else {return}
        
        
        guard let url =  URL(string: Endpoints.Gets.textToSpeech.url) else {
            print("url salah")
            return
        }
        
        let json: [String: Any] = [
            "text": text,
            "model_id": "eleven_monolingual_v1",
            "voice_settings": [
                "stability": 0.5,
                "similarity_boost": 0.5
            ]
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("audio/mpeg", forHTTPHeaderField: "accept")
        request.setValue(apiKey, forHTTPHeaderField: "xi-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        
        let task = session.uploadTask(with: request, from: jsonData){ maybeData, maybeResponse, error in
            if error != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
                print(data)
                result(.success(data))
            } else if let response = maybeResponse as? HTTPURLResponse, response.statusCode == 400 {
                result(.failure(.noDataFound))
            }
            else if let response = maybeResponse as? HTTPURLResponse, response.statusCode == 401{
                result(.failure(.unAuthorized))
            }
            
        }
        task.resume()
        
    }
    
    func fetchTextToSpeech(text: String) async throws -> Data{
        guard let apiKey: String = Bundle.main.infoDictionary?["EL_API_KEY"] as? String else {
            throw URLError.invalidURL
        }
        
        guard let url =  URL(string: Endpoints.Gets.textToSpeech.url) else {
            throw URLError.invalidURL
        }
        
        let json: [String: Any] = [
            "text": text,
            "model_id": "eleven_monolingual_v1",
            "voice_settings": [
                "stability": 0.5,
                "similarity_boost": 0.5
            ]
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("audio/mpeg", forHTTPHeaderField: "accept")
        request.setValue(apiKey, forHTTPHeaderField: "xi-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
        
    }
    
    
    
    
    //    func fetchTextToSpeech(text: String, voiceId: String) async throws -> Data {
    //        guard let url = URL(string: Endpoints.Gets.textToSpeech.url) else {
    //            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Base URL not found"])
    //        }
    //
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "POST"
    //        request.setValue("audio/mpeg", forHTTPHeaderField: "accept")
    //        request.setValue("", forHTTPHeaderField: "xi-api-key")
    //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    //        let json: [String: Any] = [
    //            "text": text,
    //            "model_id": "eleven_monolingual_v1",
    //            "voice_settings": [
    //                "stability": 0.5,
    //                "similarity_boost": 0.5
    //            ]
    //        ]
    //
    //        let jsonData = try? JSONSerialization.data(withJSONObject: json)
    //        request.httpBody = jsonData
    //        print("[ElevenLabsAPIService][fetchTextToSpeech][request]", request)
    //        let result = try await APIManager().fetchData(request: request)
    //
    //        print("[ElevenLabsAPIService][fetchTextToSpeech][result]", result)
    //        return result
    //      }
    
}

/*
 class ElevenLabsService {
     let baseURL = "https:api.elevenlabs.io/v1/text-to-speech/<voice-id>"
     / /v1/text-to-speech/{voice_id}
     func fetchTextToSpeech(text: String, voiceId: String) async throws -> Data {
         guard let url = URL(string: baseURL + "text-to-speech/\(voiceId)") else {
             throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Base URL not found"])
         }
         
         var request = URLRequest(url: url)
         request.httpMethod = "POST"
         request.setValue("audio/mpeg", forHTTPHeaderField: "accept")
         request.setValue("", forHTTPHeaderField: "xi-api-key")
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         
         let json: [String: Any] = [
             "text": text,
             "model_id": "eleven_monolingual_v1",
             "voice_settings": [
                 "stability": 0.5,
                 "similarity_boost": 0.5
             ]
         ]
         
         let jsonData = try? JSONSerialization.data(withJSONObject: json)
         request.httpBody = jsonData
         print("[ElevenLabsAPIService][fetchTextToSpeech][request]", request)
         
         let result = try await APIManager().fetchData(request: request)
         
         print("[ElevenLabsAPIService][fetchTextToSpeech][result]", result)
         return result
     }
 }
 
 */
