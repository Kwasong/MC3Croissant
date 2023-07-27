//
//  ComfortingViewModel.swift
//  MC3
//
//  Created by Wahyu Alfandi on 25/07/23.
//

import Foundation
import SwiftUI
import Combine

enum ComfortingViewState{
    case sleep
    case awake
    case occupy
    case talk
}

@MainActor class ComfortingViewModel: ObservableObject{
    @AppStorage("personality") var personality: String = "friendly"
    @AppStorage("name") var name: String = ""
    
    @Published var recognizer = SpeechRecognizer()
    
    @Published var shouldFetch: Bool = false
    @Published var answer: OpenAIAnswer?
    @Published var recognizedText: String = ""
    @Published var isRecognizing: Bool = false
    
    //View State
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isPopping: Bool = false
    
    @Published var speechSound: Data?
    @Published var isWink: Bool = false
    @Published var viewState: ComfortingViewState = .sleep
    
    
    //audio player state
    @Published var audioPlayer = AudioPlayer()
    @Published var isPlaying: Bool = false
    @Published var didFinishedPlaying: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    let wordsToDetect = ["hello", "scared"]
    @Published var helloDetected: Bool = false
    @Published var scaredDetected: Bool = false
    
    
    
    
    
    init(){
        self.recognizer.$isRecognizing.assign(to: &$isRecognizing)
        self.recognizer.$recognizedText.assign(to: &$recognizedText)
        self.recognizer.$shouldFetch.assign(to: &$shouldFetch)
        
        self.audioPlayer.$isPlaying.assign(to: &$isPlaying)
        self.audioPlayer.$didFinishedPlaying.assign(to: &$didFinishedPlaying)
        
        
        audioPlayer.$didFinishedPlaying
            .sink { [weak self] didFinishedPlaying in
                guard let self = self else {return}
                
                if didFinishedPlaying {
                    // The song has finished playing.
                    // You can perform any actions needed here.
                    // For example, play the next song, show a message, etc.
                    self.handleFinishedPlaying()
                }
            }
            .store(in: &cancellables)
    }
    
    
    func prepareAudio(track: String, withExtension: String = "mp3", isPreview: Bool = false) {
        audioPlayer.prepareAudio(track: track, withExtension: withExtension, isPreview: isPreview)
    }
    
    func playAudio() {
        audioPlayer.didFinishedPlaying = false
        audioPlayer.resumeAudio()
    }
    
    
    func startRecognition(){
        isRecognizing = true
        recognizer.startRecognition()
        
    }
    
    func stopRecognition(){
        recognizer.stopRecognition()
        isRecognizing = false
    }
    
    func sendSpeechToGPT(text: String) async throws -> OpenAIAnswer {
        isLoading = true
        
        var sendText = "answer me like an friendly person, i say'\(text)'"
        // if sassy
        if personality == "sassy"{
            sendText = "answer me like a bitchy person, i say '\(text)'"
        }
        
        let params = OpenAIRequest(prompt: sendText)
        
        let data = try await OpenAIService.sharedInstance.sendMessage(params: params)
        
        isLoading = false
        return data
        
    }
    
    func fetchTextToSpeech(text: String)  async throws -> Data{
        isLoading = true
        
        let data = try await ElevenLabsService.sharedInstance.fetchTextToSpeech(text: text)
        isLoading = false
        return data
    }
    
    func playAudioFromData(data: Data){
        audioPlayer.playFromData(track: data)
    }
    
    func detectKeyWords(recognizedText: String){
        let lowercasedText = recognizedText.lowercased()
        for word in wordsToDetect {
            if lowercasedText.contains(word) {
                // Perform actions based on detected words
                switch word {
                case "hello":
                    print("Hello detected!")
                    helloDetected = true
                    stopRecognition()
                    nextPage()
                case "scared":
                    print("Scared detected!")
                    scaredDetected = true
                    stopRecognition()
                    nextPage()
                    // Do something when "apple" is detected
                case "swift":
                    print("Swift detected!")
                    // Do something when "swift" is detected
                default:
                    break
                }
            }
        }
    }
    
    func goToTalkView(){
        
    }
    
    func nextPage(){
        DispatchQueue.main.asyncAfter(deadline: viewState == .sleep ? .now() : .now() + 0.75) {[weak self] in
            guard let self = self else {return}
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)){
                
                switch self.viewState {
                case .sleep:
                    if self.helloDetected{
                        self.viewState = .awake
                        self.helloDetected = false
                    }else if self.scaredDetected{
                        self.viewState = .talk
                        self.scaredDetected = false
                    }else{
                        self.viewState = .sleep
                    }
                    
                case .awake:
                    self.viewState = .occupy
                default:
                    self.viewState = .sleep
                }
                
                self.isPopping = true
                
            }
        }
        
    }
    
    private func handleFinishedPlaying(){
        if viewState == .occupy || viewState == .talk{
            return
        }
        
        nextPage()
    }
    
    
}
