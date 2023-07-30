//
//  SpeechRecognizer.swift
//  MC3
//
//  Created by Safik Widiantoro on 21/07/23.
//

import Foundation
import Speech
import Combine

class SpeechRecognizer: ObservableObject {
    private let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale(identifier: "en-EN"))
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    private var silenceDuration: TimeInterval = 0.0
    private var transcriptionText: SFTranscription?
    
    @Published var recognizedText: String = ""
    @Published var isRecognizing: Bool = false
    @Published private var silenceTimer: Timer?
    
    @Published var shouldFetch: Bool = false
    
    init() {}
}

extension SpeechRecognizer {
    func startRecognition(withSilent: Bool = false) {

        shouldFetch = false
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            self.recognitionTask?.cancel()
            self.recognitionTask = nil
            
            self.request = SFSpeechAudioBufferRecognitionRequest()
            
            guard let request = self.request else {
                print("Unable to create request.")
                return
            }
            
            let inputNode = self.audioEngine.inputNode
            
            request.shouldReportPartialResults = true
            
            self.recognitionTask = self.speechRecognizer?.recognitionTask(with: request) { [weak self] result, error in
                
                guard let result = result else {
                    print("Recognition failed: \(error?.localizedDescription ?? "No result")")
                    return
                    
                }
                let text = result.bestTranscription.formattedString
                self?.recognizedText = text
                
                if withSilent{
                    self?.checkSpeechActivity(result.isFinal)
                }
                
                print(self?.recognizedText)
            }
            
            
            // Start the silence timer
            self.silenceTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
                if self.isRecognizing {
                    // The timer has fired, indicating 2 seconds of silence.
                    // You can perform any action here when the user has been silent for 2 seconds.
                    print("User has been silent for more than 2 seconds")
                    self.stopRecognition()
                }
            }
            
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                self.request?.append(buffer)
            }
            
            
            self.audioEngine.prepare()
            
            do {
                try self.audioEngine.start()
                
                DispatchQueue.main.async {
                    self.isRecognizing = true
                }
                
            } catch {
                print("Could not start audio engine: \(error)")
            }
        }
        silenceDuration = 0.0
    }
    
    func stopRecognition() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            self.audioEngine.stop()
            self.audioEngine.inputNode.removeTap(onBus: 0)
            self.request = nil
            self.recognitionTask = nil
            
            DispatchQueue.main.async {
                self.isRecognizing = false
            }z
            self.silenceTimer?.invalidate()
        }
        
    }
    
    private func checkSpeechActivity(_ isFinal: Bool) {
        // Perform any action or check you want to do when speech is finished (isFinal == true)
        if isFinal {
            print("Speech is finished")
        } else {
            // Restart the silence timer if speech activity is detected
            self.silenceTimer?.invalidate()
            self.silenceTimer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { timer in
                if self.isRecognizing {
                    // The timer has fired, indicating 2 seconds of silence.
                    // You can perform any action here when the user has been silent for 2 seconds.
//                    print("User has been silent for more than 2 seconds")
                    self.shouldFetch = true
                    self.stopRecognition()
                }
            }
        }
        
    }
    
    private func displayText(to text: String) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let words = text.split(separator: " ")
            let finalWords = words.map { word -> String in
                return "\(word) "
            }
            let finalText = finalWords.joined(separator: " ")
            
            DispatchQueue.main.async {
                self?.recognizedText = finalText
            }
        }
    }
    
    func toggleRecognition() {
        isRecognizing ? stopRecognition() : startRecognition()
    }
}
