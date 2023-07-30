//
//  BreathingView.swift
//  MC3
//
//  Created by Safik Widiantoro on 19/07/23.
//

import SwiftUI

struct BreathingView: View {
    @AppStorage("personality") var personality: String = ""
    
    @State var audioPlayer = AudioPlayer()
    
    @State private var isAnimating = false
    @State private var animationStage = 0
    @State private var loopCount = 0
    @State private var animationWorkItem: DispatchWorkItem?
    
    
    @EnvironmentObject var router: Router
    @State private var doneBreathing: Bool = false
    
    @State private var timer: Timer?
    
    
    private var animationText: String {
        switch animationStage {
        case 0:
            return "Breathe In"
        case 1:
            return "Hold"
        case 2:
            return "Breathe Out"
        default:
            return "Breathe In"
        }
    }
    
    private var animationImage: String {
        switch animationStage {
        case 0:
            return personality == "friendly" ? "stage-1" : "sassy-stage-1"
        case 1:
            return personality == "friendly" ? "stage-2" : "sassy-stage-2"
        case 2:
            return personality == "friendly" ? "stage-3" : "sassy-stage-3"
        default:
            return personality == "friendly" ? "stage-1" : "sassy-stage-1"
        }
        
    }
    
    var body: some View {
        VStack(spacing: 30){
            HStack {
                BackButton {
                    router.pop()
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 50)
                Spacer()
                Button {
                    //MARK: if berikut penting buat routing
                    if router.lastMethod != .fromMain{
                        router.lastMethod = .breathing
                    }
                    stopAnimationAndAudio()
                    audioPlayer.stopBgm()
                    router.push(.assestmentView)
                } label: {
                    Text(router.lastMethod == .fromMain ? "Done" : "Skip")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.teal55)
                }
                .padding(.horizontal, 30)
                
            }
            .padding(.top, 40)
            .padding(.bottom, 68)
            
            if doneBreathing == true {
                Text("Well done!")
                    .font(.system(size: 34, weight: .bold))
                    .padding(.horizontal, 50)
                    .foregroundColor(Color.lightTeal90)
            }
            else {
                Text("Let’s practice deep breathing and relaxation techniques to calm your mind.")
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 50)
                    .foregroundColor(Color.lightTeal90)
            }
            
            ZStack{
                Circle()
                    .fill( Color.myPurple.opacity(0.25))
                    .frame(width: 350, height: 350)
                    .scaleEffect(self.isAnimating ? 0.8 : 0)
                Circle()
                    .fill(Color.myPurple.opacity(0.35))
                    .frame(width: 250, height: 250)
                    .scaleEffect(self.isAnimating ? 0.8 : 0)
                Circle()
                    .fill(Color.myPurple.opacity(0.45))
                    .frame(width: 150, height: 150)
                    .scaleEffect(self.isAnimating ? 0.8 : 0)
                
                if personality == "friendly"{
                    Image(doneBreathing ? "stage-4" : animationImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 83)
                }else{
                    Image(doneBreathing ? "sassy-stage-4" : animationImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 83)
                }
                
                
            }
            
            VStack {
                if doneBreathing == true {
                    withAnimation(Animation.easeInOut){
                        HStack(spacing: 50){
                            Button {
                                self.repeatBreathe()
                            }label: {
                                Circle()
                                    .foregroundColor(Color.myTeal)
                                    .overlay(Image(systemName: "arrow.counterclockwise"))
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: 40)
                            }
                        }
                    }
                } else {
                    Text(animationText)
                        .font(.system(size: 24, design: .default))
                        .bold()
                        .foregroundColor(Color.lightTeal90)
                }
                
                
                
            }
        }
        .ignoresSafeArea()
        .onAppear {
            audioPlayer.playBgm(track: "just-relax")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.startAnimating()
                DispatchQueue.main.asyncAfter(deadline: .now() + 57) {
                    doneBreathing = true
                    isAnimating = true
                }
            }
        }
        .onDisappear{
            stopAnimationAndAudio()
        }
        .navigationBarBackButtonHidden()
        
    }
    
    
    private func repeatBreathe() {
        self.startAnimating()
        self.loopCount = 0
        doneBreathing.toggle()
    }
    
    private func stopAnimationAndAudio() {
        // Cancel the DispatchWorkItem to stop the animations and audio
        timer?.invalidate()
        // Stop the audio player only when the view is not active
        audioPlayer.stopBgm()
        audioPlayer.stopAudio()
    }
    
    private func startAnimating() {
        guard !isAnimating else {return}
        // Stop and invalidate the timer if it's running
        timer?.invalidate()
        
        withAnimation(Animation.easeInOut(duration: 4)) {
            self.isAnimating = true
        }
        self.animationStage = 0
        
        audioPlayer.stopAudio()
        audioPlayer.prepareAudio(track: "breathIn")
        audioPlayer.resumeAudio()
        // Timer 1: After 4 seconds, update animationStage to 1
        timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { _ in
            self.animationStage = 1
            audioPlayer.stopAudio()
            audioPlayer.prepareAudio(track: "hold")
            audioPlayer.resumeAudio()
            // Timer 2: After 7 seconds, stop the animation and update animationStage to 2
            self.timer = Timer.scheduledTimer(withTimeInterval: 7, repeats: false) { _ in
                withAnimation(Animation.easeInOut(duration: 8)) {
                    self.isAnimating = false
                }
                self.animationStage = 2
                audioPlayer.stopAudio()
                audioPlayer.prepareAudio(track: "breathOut")
                audioPlayer.resumeAudio()
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
    //
    //    private func startAnimating() {
    //
    //        self.animationWorkItem = DispatchWorkItem {
    //            withAnimation(Animation.easeInOut(duration: 4)) {
    //                self.isAnimating = true
    //            }
    //
    //            self.animationStage = 0
    //            audioPlayer.prepareAudio(track: "breathIn")
    //            audioPlayer.resumeAudio()
    //
    //
    //            DispatchQueue.main.asyncAfter(deadline: .now() + 4 ) {
    //                self.animationStage = 1
    //                audioPlayer.stopAudio()
    //                audioPlayer.prepareAudio(track: "hold")
    //                audioPlayer.resumeAudio()
    //                DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
    //                    withAnimation(Animation.easeInOut(duration: 8)) {
    //                        self.isAnimating = false
    //                    }
    //                    self.animationStage = 2
    //                    audioPlayer.stopAudio()
    //                    audioPlayer.prepareAudio(track: "breathOut")
    //                    audioPlayer.resumeAudio()
    //                    self.loopCount += 1
    //
    //                    if self.loopCount  < 3 {
    //                        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
    //                            self.startAnimating()
    //                            self.animationStage = 0
    //
    //                        }
    //                    }
    //                }
    //
    //            }
    //
    //        }
    //        animationWorkItem?.perform()
    //    }
    
    
    
}

struct BreathingView_Previews: PreviewProvider {
    static var previews: some View {
        BreathingView()
    }
}
