//
//  ComfortingView.swift
//  MC3
//
//  Created by Sha Nia Siahaan on 22/07/23.
//

import SwiftUI

struct ComfortingView: View {
    @EnvironmentObject var router: Router
    @StateObject var viewModel: ComfortingViewModel = ComfortingViewModel()
    @State var isWink: Bool = false
    var body: some View {
        ZStack{
            VStack{
                if (viewModel.viewState == .sleep || viewModel.viewState == .talk ) {
                    HStack {
                        BackButton {
                            router.pop()
                        }
                        .padding(.vertical, 50)
                        .padding(.horizontal, 30)
                        Spacer()
                    }
                }
                Spacer()
                
                if (viewModel.personality == "friendly") {
                    Image( isWink ? "sleepGhone" : "ghone")
                        .resizable()
                        .scaledToFit()
                        .offset(y: viewModel.isPopping ? 40 : screenHeight * 0.43)
                    
                } else {
                    
                    Image( isWink ? "sleepSassyGhone" : "sassyGhone")
                        .resizable()
                        .scaledToFit()
                        .offset(y: viewModel.isPopping ? 40 : screenHeight * 0.43)
                }
            }
            .frame(height: screenHeight)
            
            VStack {
                switch(viewModel.viewState){
                case .sleep:
                    Sleep(viewModel: viewModel)
                case .awake:
                    Awake(viewModel: viewModel)
                case .occupy:
                    AwakeNext(viewModel: viewModel)
                case .talk:
                    AwakeTalk(viewModel: viewModel)
//                default:
//                    Sleep(viewModel: viewModel)
                }
            }
            VStack{
                Spacer()
                ProgressView().opacity(viewModel.isLoading ? 1.0 : 0.0)
            }
        }
        .background {
            Color.white
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear{
            startWinkTimer()
        }
        .navigationBarBackButtonHidden(true)
        
    }
    func startWinkTimer() {
        Timer.scheduledTimer(withTimeInterval: 3.5, repeats: true) { _ in
            withAnimation (.none){
                isWink.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    isWink.toggle()
                }
            }
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
            if let speechSound = viewModel.speechSound {
                viewModel.playAudioFromData(data: speechSound)
                print(speechSound)
                return
            }
            if viewModel.personality == "friendly"{
                viewModel.prepareAudio(track: "friendly-comforting1")
                viewModel.playAudio()
            }else {
                viewModel.prepareAudio(track: "sassy-comforting1")
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
        .onAppear{
            viewModel.startRecognition()
            Task{
                let text = "Hi, \(viewModel.name). Don't worry... you are not alone... I am here to support you..."
                
                do{
                    viewModel.speechSound = try await viewModel.fetchTextToSpeech(text: text)
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
        .onChange(of: viewModel.recognizedText) { newValue in
            viewModel.detectKeyWords(recognizedText: viewModel.recognizedText)
        }
        
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
                router.push(.breathingView)
            }
            .padding(.horizontal, 40)
        }
        .padding(.vertical, 100)
        .frame(height: screenHeight)
        .animation(.easeInOut, value: 0.5)
        .onAppear{
            if viewModel.personality == "friendly"{
                viewModel.prepareAudio(track: "friendly-comforting2")
                viewModel.playAudio()
            }else {
                viewModel.prepareAudio(track: "sassy-comforting2")
                viewModel.playAudio()
            }
            
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
        .onAppear{
            //stop dulu recognisi nya
            //start recognisi
            //user berbicara, hingga 2 detik silent
            //fetch
            //play audio hasil fetch
            //recognisi lagi
            viewModel.prepareAudio(track: "friendly-talk")
            viewModel.playAudio()
            
        }
        .onChange(of: viewModel.didFinishedPlaying){ finished in
            if finished {
                viewModel.startRecognition()
            }
        }
        .onChange(of: viewModel.shouldFetch) { shouldFetch in
            if shouldFetch{
                viewModel.stopRecognition()

                if viewModel.recognizedText != "" {
                    print("request text here \(viewModel.recognizedText)")
                    
                    Task{
                        let data =  try await viewModel.sendSpeechToGPT(text: viewModel.recognizedText)
                        viewModel.answer = data
                        print("answer from gpt : \(String(describing: viewModel.answer))")
                        if viewModel.answer != nil, viewModel.answer?.content != "" {
                            let speechSound = try await viewModel.fetchTextToSpeech(text: viewModel.answer?.content ?? "tell me about swift")
                            viewModel.stopRecognition()
                            viewModel.playAudioFromData(data: speechSound)
                        }
                        
                        viewModel.recognizedText = ""
                        viewModel.speechSound = nil
                        viewModel.startRecognition()
                    }
                    
                }
                
                
                
//                print("Should fetch: \(shouldFetch)")
//                viewModel.stopRecognition()
//                if viewModel.recognizedText != ""{
//                    viewModel.sendSpeechToGPT(text: viewModel.recognizedText)
//                    guard let answer = viewModel.answer else{
//                        print("answer not found")
//                        return
//                    }
//                    print(answer.content!)
//                    viewModel.fetchTextToSpeech(text: answer.content!)
//                    guard let speechSound = viewModel.speechSound else {return}
//                    viewModel.playAudioFromData(data: speechSound)
//                    viewModel.recognizedText = ""
//                    viewModel.speechSound = nil
//                }
                
            }
        }
        
    }
}

struct ComfortingView_Previews: PreviewProvider {
    static var previews: some View {
        ComfortingView()
    }
}
