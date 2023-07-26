//
//  ComfortingView.swift
//  MC3
//
//  Created by Sha Nia Siahaan on 22/07/23.
//

import SwiftUI

struct ComfortingView: View {
    @StateObject var viewModel: ComfortingViewModel = ComfortingViewModel()
    var body: some View {
        ZStack{
            VStack{
                if (viewModel.currentIndex < 2) {
                    HStack {
                        BackButton {
                            
                        }
                        .padding(.vertical, 50)
                        .padding(.horizontal, 30)
                        Spacer()
                    }
                }
                Spacer()
                if (viewModel.personality == "friendly") {
                    ZStack{
                        if (viewModel.isWink == true) {
                            Image("sleepGhone")
                                .resizable()
                                .scaledToFit()
                                .offset(y: 40)
                        }
                        else {
                            Image("ghone")
                                .resizable()
                                .scaledToFit()
                                .offset(y: viewModel.isPopping ? 40 : screenHeight * 0.43)
                        }
                        
                    }
                } else {
                    ZStack{
                        if (viewModel.isWink == true) {
                            Image("sleepSassyGhone")
                                .resizable()
                                .scaledToFit()
                                .offset(y: 40)
                        }
                        else {
                            Image("sassyGhone")
                                .resizable()
                                .scaledToFit()
                                .offset(y: viewModel.isPopping ? 40 : screenHeight * 0.43)
                        }
                        
                    }
                }
                
            }
            .frame(height: screenHeight)
            
            VStack {
                switch(viewModel.currentIndex){
                case 0:
                    Sleep(viewModel: viewModel)
                case 1:
                    Awake(viewModel: viewModel)
                case 2:
                    AwakeNext(viewModel: viewModel)
                default:
                    Sleep(viewModel: viewModel)
                }
            }
        }
        .background {
            Color.white
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear{
            viewModel.startRecognition()
            let text = "Hi, \(viewModel.name). Don't worry... you are not alone... I am here to support you..."
            viewModel.fetchTextToSpeech(text: text)
        }
        .onChange(of: viewModel.recognizedText) { newValue in
            viewModel.detectKeyWords(recognizedText: viewModel.recognizedText)
            
        }
    }
}

struct Awake: View {
    @ObservedObject var viewModel: ComfortingViewModel
    var body: some View {
        VStack {
            VStack(spacing: 10){
                Text(viewModel.personality == "friendly" ? "Hi, \(viewModel.name)." : "Oh, it’s you, \(viewModel.name).")
                    .font(.system(size: 30, weight: .bold))
                Text(viewModel.personality == "friendly" ? "Don't worry, you are not alone. I am here to support you." : "You're scared? Geez, ghosts aren't real, but your ability to jump to conclusions is top-notch.")
                
            }
            .foregroundColor(.lightTeal90)
            .multilineTextAlignment(.center)
            .frame(width: screenWidth*3/4)
            Spacer()
        }
        .padding(.vertical, 100)
        .frame(height: screenHeight*5/6)
        .animation(.easeInOut, value: 0.5)
        .onAppear{
            viewModel.stopRecognition()
            //cek apakah ada sound, kalo ada play, kalo gaada berarti play default
            if let speechSound = viewModel.speechSound{
                viewModel.playAudioFromData(data: speechSound)
            }
            if viewModel.personality == "friendly"{
                viewModel.prepareAudio(track: "friendly-comforting1")
                viewModel.playAudio()
            }
           
        }
    }
}

struct Sleep: View {
    @ObservedObject var viewModel: ComfortingViewModel
    var body: some View {
        VStack {
            VStack{
                Text("Wake me up if you feel scared")
                    .font(.system(size: 30, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.lightTeal90)
                    .padding(.vertical, 100)
            }
            Spacer()
            VStack(spacing: 5){
                Text("Say \"Hello!\" to wake me up")
                Text("Say \"I'm scared\" to talk with me")
            }
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(.lightTeal80)
            .opacity(viewModel.isPopping ? 0 : 1)
        }
        .frame(height: screenHeight*5/6)
        .animation(.easeInOut, value: 0.5)
        
    }
}

struct AwakeNext: View {
    @EnvironmentObject var router: Router
    
    @ObservedObject var viewModel: ComfortingViewModel
    var body: some View {
        VStack {
            Text(viewModel.personality == "friendly" ? "Let's find ways to distract and occupy your mind.." : "It's not like I want to help you, but I guess we could explore some activities to occupy your mind for a while.")
                .foregroundColor(.lightTeal90)
                .multilineTextAlignment(.center)
                .padding(.vertical, 100)
                .frame(width: screenWidth*4/5)
            Spacer()
            
            PrimaryButton(title: "Let's Go") {
                router.push(.breathing)
            }
        }
        .padding(.vertical, 100)
        .frame(height: screenHeight)
        .animation(.easeInOut, value: 0.5)
        .onAppear{
            viewModel.prepareAudio(track: "friendly-comforting2")
            viewModel.playAudio()
        }
    }
}

struct AwakeTalk: View {
    @ObservedObject var viewModel: ComfortingViewModel
    var body: some View {
        VStack(spacing: 10){
            Text(viewModel.personality == "friendly" ? "Let's talk!" : "OK, let’s talk.")
                .font(.system(size: 34, weight: .bold))
            Text(viewModel.personality == "friendly" ? "Go ahead, I’m all ears for you." : "I’ll listen when I care.")
            Spacer()
        }
        .padding(.vertical, 100)
        .frame(height: screenHeight*5/6)
        .foregroundColor(.lightTeal90)
        
    }
}

struct ComfortingView_Previews: PreviewProvider {
    static var previews: some View {
        ComfortingView()
    }
}
