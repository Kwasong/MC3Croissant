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
    func sendMessage(request: OpenAIRequest, completion: @escaping(Result<OpenAIResponse, URLError>) -> Void) async {
        guard let request = try? JSONEncoder().encode(request) else {return}
        
        guard let url = URL(string: Endpoints.Gets.completion.url) else {
            return
        }
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        
    }
}
