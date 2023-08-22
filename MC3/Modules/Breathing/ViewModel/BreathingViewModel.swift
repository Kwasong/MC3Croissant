//
//  BreathingViewModel.swift
//  MC3
//
//  Created by Wahyu Alfandi on 22/08/23.
//

import Foundation
import SwiftUI

class BreathingViewModel: ObservableObject {
    
    @Published var audioPlayer = AudioPlayer()
    @Published var isAnimating = false
    @Published var animationStage = 0
    @Published var loopCount = 0
    @Published var doneBreathing: Bool = false
    @Published var timer: Timer?
    
    func repeatBreathe() {
        self.startAnimating()
        loopCount = 0
        doneBreathing.toggle()
    }
    
    func stopAnimationAndAudio() {
        // Cancel the DispatchWorkItem to stop the animations and audio
        timer?.invalidate()
        // Stop the audio player only when the view is not active
        audioPlayer.stopBgm()
        audioPlayer.stopAudio()
    }
    
    func startAnimating() {
        guard !isAnimating else {return}
        timer?.invalidate()
        
        withAnimation(Animation.easeInOut(duration: 4)) {
            self.isAnimating = true
        }
        
        self.animationStage = 0
        audioPlayer.stopAudio()
        audioPlayer.prepareAudio(track: "breathIn")
        audioPlayer.resumeAudio()
        
        // Timer 1: After 4 seconds, update animationStage to 1
        timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { [weak self] _ in
            guard let self = self else {return}
            self.animationStage = 1
            self.audioPlayer.stopAudio()
            self.audioPlayer.prepareAudio(track: "hold")
            self.audioPlayer.resumeAudio()
            // Timer 2: After 7 seconds, stop the animation and update animationStage to 2
            self.timer = Timer.scheduledTimer(withTimeInterval: 7, repeats: false) { _ in
                withAnimation(Animation.easeInOut(duration: 8)) {
                    self.isAnimating = false
                }
                self.animationStage = 2
                self.audioPlayer.stopAudio()
                self.audioPlayer.prepareAudio(track: "breathOut")
                self.audioPlayer.resumeAudio()
                self.loopCount += 1
                
                if self.loopCount < 3 {
                    // Timer 3: After 8 seconds, start the animation again and reset animationStage to 0
                    self.timer = Timer.scheduledTimer(withTimeInterval: 8, repeats: false) { _ in
                        self.startAnimating()
                        self.animationStage = 0
                    }
                }
            }
        }
    }
}
