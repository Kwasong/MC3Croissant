//
//  ComfortingView.swift
//  MC3
//
//  Created by Sha Nia Siahaan on 22/07/23.
//

import SwiftUI



struct ComfortingView: View {
    @Namespace var namespace
    
    @StateObject var viewModel = ComfortingViewModel()
    
    
    var body: some View {
        ZStack{
            Color.white
            VStack{
                Spacer()
                ZStack{
                    Image("ghone")
                        .resizable()
                        .scaledToFit()
                        .offset(y: viewModel.isPopping ? 40 : screenHeight * 0.42)
                }
            }
            .frame(width: screenWidth, height: screenHeight)
            
            VStack {
                if viewModel.currentIndex == 0 {
                    Sleep(namespace: namespace, isPopping: $viewModel.isPopping)
                }else if viewModel.currentIndex == 1{
                    Awake(namespace: namespace, viewModel: viewModel, isPopping: $viewModel.isPopping)
                } else {
                    AwakeNext(namespace: namespace, viewModel: viewModel)
                }
                
            }
            
        }
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
    let namespace : Namespace.ID
    @AppStorage("name") var name:String = ""
    @ObservedObject var viewModel: ComfortingViewModel
    @Binding var isPopping: Bool
    
    var body: some View {
        VStack {
            VStack(spacing: 10){
                Text("Hi, \(name).")
                    .font(.system(size: 30, weight: .bold))
                Text("Don't worry, you are not alone. I am here to support you.")
                
            }
            .foregroundColor(.lightTeal90)
            .multilineTextAlignment(.center)
            .frame(width: screenWidth*3/4)
            Spacer()
        }
        
        .padding(.vertical, 100)
        .frame(height: screenHeight*4/5)
        .onAppear{
            viewModel.stopRecognition()
            //kalo speech sound nya ada berarti play
            if let speechSound = viewModel.speechSound {
                print("audio found")
                viewModel.playAudioFromData(data: speechSound)
                return
            }
            print("[request here]")

            viewModel.prepareAudio(track: "friendly-comforting1")
            viewModel.playAudio()
        }
        
    }
}

struct Sleep: View {
    let namespace : Namespace.ID
    @Binding var isPopping: Bool
    
    var body: some View {
        VStack {
            VStack(){
                Text("Wake me up if you feel scared")
                    .font(.system(size: 30, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.lightTeal90)
                    .padding(.vertical, 100)
            }
            Spacer()
            VStack{
                Text("Say \"Hello!\" to wake me up")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.lightTeal80)
                    .opacity(isPopping ? 0 : 1)
            }
        }
        .frame(height: screenHeight*4/5)
        .animation(.easeInOut, value: 0.5)
    }
}

struct AwakeNext: View {
    let namespace : Namespace.ID
    @ObservedObject var viewModel: ComfortingViewModel
    @EnvironmentObject var router: Router
    var body: some View {
        VStack {
            Text("Let's find ways to distract and occupy your mind..")
                .foregroundColor(.lightTeal90)
                .multilineTextAlignment(.center)
                .frame(width: screenWidth*3/4)
                .padding(.top, 100)
            Spacer()
            
            PrimaryButton(title: "Let's Go") {
//                router.push(.)
            }
        }
        
        .frame(height: screenHeight*3/4)
        .onAppear{
            viewModel.prepareAudio(track: "friendly-comforting2")
            viewModel.playAudio()
        }
    }
}

struct ComfortingView_Previews: PreviewProvider {
    static var previews: some View {
        ComfortingView()
    }
}
