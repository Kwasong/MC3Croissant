//
//  ComfortingViewModel.swift
//  MC3
//
//  Created by Wahyu Alfandi on 25/07/23.
//

import Foundation
import SwiftUI
import Combine



@MainActor class ComfortingViewModel: ObservableObject{
    
    enum GhoneState{
        case isTalking
        case isListening
    }
    
    @AppStorage("personality") var personality: String = "friendly"
    @AppStorage("name") var name: String = ""
    @Published var recognizer = SpeechRecognizer()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var answer: OpenAIAnswer?
    @Published var recognizedText: String = ""
    @Published var isRecognizing: Bool = false
    
    //View State
    @Published var isPopping: Bool = false
    @Published var currentIndex: Int = 0
    @Published var speechSound: Data?
    @Published var isWink: Bool = false
    
    // state ghone
    @Published var ghoneState: GhoneState = .isListening
    
    //audio player state
    @Published var audioPlayer = AudioPlayer()
    @Published var isPlaying: Bool = false
    @Published var didFinishedPlaying: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    let wordsToDetect = ["hello", "apple", "swift"]
    
    
    
    
    
    init(){
        self.recognizer.$isRecognizing.assign(to: &$isRecognizing)
        self.recognizer.$recognizedText.assign(to: &$recognizedText)
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
    
    func sendSpeechToGPT(text: String){
        isLoading = true
        
        var sendText = "answer me like an friendly person, i say'\(text)'"
        // if sassy
        if personality == "sassy"{
            sendText = "answer me like a bitchy person, i say '\(text)'"
        }
        
        let params = OpenAIRequest(prompt: sendText)
        OpenAIService.sharedInstance.sendMessage(params: params) { [weak self] remoteResponse in
            guard let self = self else {return}
            switch remoteResponse{
            case .success(let data):
                let chat = OpenAIAnswerMapper.mapOpenAIResponseToAnswer(input: data)
                answer = chat
                self.isLoading = false
            case .failure(let error):
                errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    func fetchTextToSpeech(text: String)  {
        isLoading = true
        
        ElevenLabsService.sharedInstance.fetchTextToSpeech(text: text) { [weak self] remoteResponse in
            guard let self = self else {return}
            
            switch remoteResponse{
            case .success(let data):
                speechSound = data
                isLoading = false
            case .failure(let error):
                errorMessage = error.localizedDescription
                print(error.localizedDescription)
                isLoading = false
            }
        }
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
                    nextPage()
                case "scared":
                    print("Scared detected!")
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
    
    func nextPage(){
        DispatchQueue.main.asyncAfter(deadline: currentIndex == 0 ? .now() : .now() + 0.75) {[weak self] in
            guard let self = self else {return}
            withAnimation(.spring(dampingFraction: 0.5)){
                self.isPopping = true
                self.currentIndex += 1
                
            }
        }
        
    }
    
    private func handleFinishedPlaying(){
        if currentIndex == 2{
            return
        }
        
        nextPage()
    }
    
    func startWinkTimer() {
        Timer.scheduledTimer(withTimeInterval: 4.9, repeats: true) { _ in
            withAnimation() {
                self.isWink.toggle()
            }
        }
    }
}
