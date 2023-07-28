//
//  BreathingView.swift
//  MC3
//
//  Created by Safik Widiantoro on 19/07/23.
//

import SwiftUI

struct BreathingView: View {
    @State var audioPlayer = AudioPlayer()
    
    @State private var isAnimating = false
    @State private var animationStage = 0
    @State private var loopCount = 0
    
    @EnvironmentObject var router: Router
    
    @State private var doneBreathing: Bool = false
    
    
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
            return "stage-1"
        case 1:
            return "stage-2"
        default:
            return "stage-1"
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
                    audioPlayer.stopBgm()
                    audioPlayer.stopAudio()
                } label: {
                    Text("Skip")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.teal55)
                }
                .padding(.horizontal, 30)
                
            }
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
                
                Image(doneBreathing ? "stage-4" : animationImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 83)
                
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.startAnimating()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 57) {
                        doneBreathing = true
                        isAnimating = true
                    }
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
                            Button {
                                loopCount = 3
                                startAnimating()
                                audioPlayer.stopBgm()
                                audioPlayer.stopAudio()
                                
                            }label: {
                                Circle()
                                    .foregroundColor(Color.myTeal)
                                    .overlay(Image(systemName: "chevron.right"))
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
                
                Button {
                    loopCount = 3
                    audioPlayer.stopBgm()
                    audioPlayer.stopAudio()
                    router.push(.assestmentView(lastMethod: .breathing))
                }label: {
                    Circle()
                        .foregroundColor(Color.purple30)
                        .overlay(Image(systemName: "chevron.right"))
                        .foregroundColor(Color.white)
                        .frame(maxWidth: 40)
                    
                }
                
            }
        }
        .onAppear{
            audioPlayer.playBgm(track: "just-relax")
        }
        .onDisappear{
            audioPlayer.stopBgm()
            audioPlayer.stopAudio()
        }
        
        .navigationBarBackButtonHidden()
        
    }
    
    
    private func repeatBreathe() {
        self.startAnimating()
        self.loopCount = 0
        doneBreathing.toggle()
    }
    
    
    private func startAnimating() {
        
//        let queue = DispatchWorkItem {
//            startAnimating()
//        }
//        queue.cancel()
        
        withAnimation(Animation.easeInOut(duration: 4)) {
            self.isAnimating = true
        }
        
        self.animationStage = 0
        audioPlayer.prepareAudio(track: "breathIn")
        audioPlayer.resumeAudio()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4 ) {
            if self.loopCount > 2{
                return
                
            }
            self.animationStage = 1
            audioPlayer.stopAudio()
            audioPlayer.prepareAudio(track: "hold")
            audioPlayer.resumeAudio()
            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                withAnimation(Animation.easeInOut(duration: 8)) {
                    self.isAnimating = false
                }
                self.animationStage = 2
                audioPlayer.stopAudio()
                audioPlayer.prepareAudio(track: "breathOut")
                audioPlayer.resumeAudio()
                self.loopCount += 1
                
                if self.loopCount < 3 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                        self.startAnimating()
                        self.animationStage = 0
                        
                    }
                }
            }
            
        }
        
    }
    
    
    
    
}

struct BreathingView_Previews: PreviewProvider {
    static var previews: some View {
        BreathingView()
    }
}
