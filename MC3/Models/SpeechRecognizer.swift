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
    private var silenceTimer: Timer?
    private var silenceDuration: TimeInterval = 0.0
    
    @Published var recognizedText: String = ""
    @Published var isRecognizing: Bool = false
    
    init() {}
}

extension SpeechRecognizer {
    private func startRecognition() {
        recognizedText = ""
        silenceTimer?.invalidate()

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.recognitionTask?.cancel()
            self?.recognitionTask = nil
            
            self?.request = SFSpeechAudioBufferRecognitionRequest()
            
            guard let request = self?.request else {
                print("Unable to create request.")
                return
            }
            
            guard let inputNode = self?.audioEngine.inputNode else {
                print("Audio engine has no input node.")
                return
            }
            
            request.shouldReportPartialResults = true
            
            self?.recognitionTask = self?.speechRecognizer?.recognitionTask(with: request) { [weak self] result, error in
                guard let result = result else {
                    print("Recognition failed: \(error?.localizedDescription ?? "No result")")
                    return
                }
                
                let text = result.bestTranscription.formattedString
                
                self?.displayText(to: text)
                print(text)
            }
            
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                self.request?.append(buffer)
            }
            
            
            self.audioEngine.prepare()
            
            do {
                try self.audioEngine.start()
                
                DispatchQueue.main.async {
                    self.isRecognizing.toggle()
                }
                
            } catch {
                print("Could not start audio engine: \(error)")
            }
        }
        silenceDuration = 0.0
        startSilenceTimer()
    }
    
    private func startSilenceTimer() {
        silenceTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            self.silenceDuration += 0.1
            
            if self.silenceDuration >= 2.0 {
                // Print "woi" when 2 seconds of silence have passed
                //TODO: Prompt chat gpt
                print("woi")
                self.stopRecognition()
            }
        }
        self.silenceTimer?.invalidate()
        
    }
    
    
    private func stopRecognition() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            self.audioEngine.stop()
            self.audioEngine.inputNode.removeTap(onBus: 0)
            self.request = nil
            self.recognitionTask = nil
            
            DispatchQueue.main.async {
                self.isRecognizing.toggle()
            }
        }
        self.silenceTimer?.invalidate()
        
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
