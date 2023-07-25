//
//  ChatCompletionService.swift
//  MC3
//
//  Created by Wahyu Alfandi on 24/07/23.
//

import Foundation
import SwiftUI

class OpenAIService: NSObject, URLSessionDelegate{
    private override init() {}
    static let sharedInstance: OpenAIService = OpenAIService()
}

extension OpenAIService{
    func sendMessage(params: OpenAIRequest, result: @escaping(Result<OpenAIResponse, URLError>) -> Void) {
        guard let apiKey: String = Bundle.main.infoDictionary?["API_KEY"] as? String else {return}
        print(apiKey)
        guard let openAIRequest = try? JSONEncoder().encode(params) else {
            print("parameter salah")
            return
            
        }
        
        guard let url = URL(string: Endpoints.Gets.completion.url) else {
            print("url salah")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        
        let task = session.uploadTask(with: request, from: openAIRequest) { maybeData, maybeResponse, error in
            if error != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                
                do {
                    let data = try decoder.decode(OpenAIResponse.self, from: data)
                    result(.success(data))
                } catch {
                    result(.failure(.invalidResponse))
                }
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
