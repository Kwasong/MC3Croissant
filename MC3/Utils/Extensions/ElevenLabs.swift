//
//  ElevenLabs.swift
//  MC3
//
//  Created by Safik Widiantoro on 24/07/23.
//

import Foundation

class ElevenLabsService {
    let baseURL = "https://api.elevenlabs.io/v1/text-to-speech/<voice-id>"
    /// /v1/text-to-speech/{voice_id}
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



