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
                "similarity_boost": 0.75
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
}

