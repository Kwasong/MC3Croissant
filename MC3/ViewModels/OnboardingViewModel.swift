//
//  OnboardingViewModels.swift
//  MC3
//
//  Created by Wahyu Alfandi on 16/07/23.
//

import Foundation
import Combine

@MainActor final class OnboardingViewModel: ObservableObject {
    
    @Published var index: Int = 0
    @Published var name: String = ""
    @Published var personality: String = "friendly"
    
    //audio player state
    @Published var audioPlayer = AudioPlayer()
    @Published var isPlaying: Bool = false
    @Published var didFinishedPlaying: Bool = false
    
    //validation
    @Published var isNameError: Bool = false
    @Published var isPersonalityError: Bool = false
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    
    init(){
        self.audioPlayer.$isPlaying.assign(to: &$isPlaying)
        self.audioPlayer.$didFinishedPlaying.assign(to: &$didFinishedPlaying)
    }
    
    func prepareAudio(track: String, withExtension: String = "mp3", isPreview: Bool = false) {
        audioPlayer.prepareAudio(track: track, withExtension: withExtension, isPreview: isPreview)
    }
    
    func playAudio() {
        audioPlayer.didFinishedPlaying = false
        audioPlayer.resumeAudio()
    }
    
    
    func stopAudio(){
        audioPlayer.stopAudio()
    }
    
    func validateName(){
        isNameError = false
        if name == "" {
            errorMessage = "Name cant be empty"
            isNameError = true
            showAlert = true
        }
    }
    
    func validatePersonality(){
        isPersonalityError = false
    }
}
