//
//  BreathingView.swift
//  MC3
//
//  Created by Safik Widiantoro on 19/07/23.
//

import SwiftUI

struct BreathingView: View {
    @EnvironmentObject var router: Router
    @AppStorage("personality") var personality: String = ""
    @StateObject var viewModel = BreathingViewModel()
    
    private var animationText: String {
        switch viewModel.animationStage {
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
        switch viewModel.animationStage {
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
                    if router.lastMethod != .fromMain{
                        router.lastMethod = .breathing
                    }
                    viewModel.stopAnimationAndAudio()
                    viewModel.audioPlayer.stopBgm()
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
            
            if viewModel.doneBreathing == true {
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
                    .scaleEffect(viewModel.isAnimating ? 0.8 : 0)
                Circle()
                    .fill(Color.myPurple.opacity(0.35))
                    .frame(width: 250, height: 250)
                    .scaleEffect(viewModel.isAnimating ? 0.8 : 0)
                Circle()
                    .fill(Color.myPurple.opacity(0.45))
                    .frame(width: 150, height: 150)
                    .scaleEffect(viewModel.isAnimating ? 0.8 : 0)
                
                if personality == "friendly"{
                    Image(viewModel.doneBreathing ? "stage-4" : animationImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 83)
                }else{
                    Image(viewModel.doneBreathing ? "sassy-stage-4" : animationImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 83)
                }
                
                
            }
            
            VStack {
                if viewModel.doneBreathing == true {
                    withAnimation(Animation.easeInOut){
                        HStack(spacing: 50){
                            Button {
                                viewModel.repeatBreathe()
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
            viewModel.audioPlayer.playBgm(track: "just-relax")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                viewModel.startAnimating()
                DispatchQueue.main.asyncAfter(deadline: .now() + 57) {
                    viewModel.doneBreathing = true
                    viewModel.isAnimating = true
                }
            }
        }
        .onDisappear{
            viewModel.stopAnimationAndAudio()
        }
        .navigationBarBackButtonHidden()
        
    }
    
    
    
    
       
}

struct BreathingView_Previews: PreviewProvider {
    static var previews: some View {
        BreathingView()
    }
}
