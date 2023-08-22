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
    
    @Published var answer: OpenAIAnswer?
    @Published var speechSound: Data?
    @Published var recognizer = SpeechRecognizer()
    @Published var recognizedText: String = ""
    @Published var isRecognizing: Bool = false
    
    //View State
    @Published var shouldFetch: Bool = false
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isPopping: Bool = false
    @Published var isWink: Bool = false
    @Published var viewState: ComfortingViewState = .sleep
    
    //audio player state
    @Published var audioPlayer = AudioPlayer()
    @Published var isPlaying: Bool = false
    @Published var didFinishedPlaying: Bool = false
    
    let wordsToDetect = ["hello", "scared"]
    @Published var helloDetected: Bool = false
    @Published var scaredDetected: Bool = false
    
    
    private var cancellables: Set<AnyCancellable> = []
    private let usecase: GhoneUseCaseProtocol
    
    init(){
        self.usecase = Injection.init().provideGhoneUseCase()
        setupBindings()
    }
    
    private func setupBindings() {
        setupRecognizerBindings()
        setupAudioPlayerBindings()
    }
    
    private func setupRecognizerBindings() {
        recognizer.$isRecognizing.assign(to: &$isRecognizing)
        recognizer.$recognizedText.assign(to: &$recognizedText)
        recognizer.$shouldFetch.assign(to: &$shouldFetch)
    }
    
    private func setupAudioPlayerBindings() {
        audioPlayer.$isPlaying.assign(to: &$isPlaying)
        audioPlayer.$didFinishedPlaying.assign(to: &$didFinishedPlaying)
        
        audioPlayer.$didFinishedPlaying
            .sink { [weak self] didFinishedPlaying in
                guard let self = self else { return }
                if didFinishedPlaying {
                    self.handleAudioPlaybackCompletion()
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: Business Logic
    func sendTextToAI(text: String) async throws {
        isLoading = true
        
        var sendText = "answer me like an friendly person, i say'\(text)'"
        if personality == "sassy"{
            sendText = "answer me like a bitchy but a little bit kind person, i say '\(text)'"
        }
        
        let result = await usecase.sendMessage(text: sendText)
        
        switch result {
            case .success(let data):
                self.answer = data
            case .failure(let error):
                print(error.localizedDescription)
        }
        isLoading = false
    }
    
    func fetchTextToSpeech(text: String)  async throws {
        isLoading = true
        
        let result = await usecase.fetchTextToSpeech(text: text)
        
        switch result {
            case .success(let data):
                self.speechSound = data
            case .failure(let error):
                print(error.localizedDescription)
        }
        isLoading = false
    }
    
    func prepareAudio(track: String, withExtension: String = "mp3") {
        audioPlayer.prepareAudio(track: track, withExtension: withExtension)
    }
    
    func playAudio() {
        audioPlayer.didFinishedPlaying = false
        audioPlayer.resumeAudio()
    }
    
    func stopAudio(){
        audioPlayer.stopAudio()
    }
    
    func playAudioFromData(data: Data){
        audioPlayer.playFromData(track: data)
    }
    
    private func handleAudioPlaybackCompletion(){
        if viewState == .occupy || viewState == .talk{
            return
        }
        
        navigateToNextPage()
    }
    
    //MARK: Recognizer
    
    func startRecognition(withSilent: Bool){
        isRecognizing = true
        recognizer.startRecognition(withSilent: withSilent)
    }
    
    func stopRecognition(){
        recognizer.stopRecognition()
        isRecognizing = false
    }
    
    func detectKeyWords(recognizedText: String){
        let lowercasedText = recognizedText.lowercased()
        for word in wordsToDetect {
            if lowercasedText.contains(word) {
                switch word {
                    case "hello":
                        print("Hello detected!")
                        helloDetected = true
                        stopRecognition()
                        navigateToNextPage()
                    case "scared":
                        print("Scared detected!")
                        scaredDetected = true
                        stopRecognition()
                        navigateToNextPage()
                    default:
                        break
                }
            }
        }
    }
    
    //Mark: Navigation
    func navigateToNextPage(){
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
}
