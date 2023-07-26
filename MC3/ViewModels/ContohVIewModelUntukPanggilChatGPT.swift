//
//  ContohVIewModelUntukPanggilChatGPT.swift
//  MC3
//
//  Created by Wahyu Alfandi on 24/07/23.
//

import Foundation
import SwiftUI
/*
 ini contoh view model buat GPT, kalo mau dipake tinggal panggil sendMessage kasi parameter string sebagai promptnya
 */


@MainActor class GPTViewModel: ObservableObject{
    @Published var chat: ChatMessage?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    
    func sendMessage(prompt: String, result: @escaping(Result<OpenAIResponse, URLError>) -> Void){
       isLoading = true
        
        let params = OpenAIRequest(model: "text-davinci-003", prompt: prompt, temperature: 0.5, max_tokens: 256)
        
        //panggil service nya.
        OpenAIService.sharedInstance.sendMessage(params: params) {[weak self] remoteResponse in
            
            guard let self = self else {return}
            switch remoteResponse{
            case .success(let data):
                let chat = ChatMessageMapper.mapOpenAIResponseToChatMessage(input: data)
                self.chat = chat
                self.isLoading = false
            case .failure(let error):
                errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
