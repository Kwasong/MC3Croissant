//
//  ComfortingView.swift
//  MC3
//
//  Created by Sha Nia Siahaan on 22/07/23.
//

import SwiftUI

struct ComfortingView: View {
    @Namespace var namespace
    
    @State var username: String = "Shan"
    @State var isPopping: Bool = false
    @State var currentIndex: Int = 0
    @State var isWink: Bool = false
    @State var personality: String = "nice"
    var body: some View {
        NavigationStack{
                    ZStack{
                        VStack{
                            if (currentIndex < 2) {
                                HStack {
                                    BackButton {
                                        
                                    }
                                    .padding(.vertical, 50)
                                    .padding(.horizontal, 30)
                                    Spacer()
                                }
                            }
                            Spacer()
                            if (personality == "nice") {
                                ZStack{
                                    if (isWink == true) {
                                        Image("sleepGhone")
                                            .resizable()
                                            .scaledToFit()
                                            .offset(y: 40)
                                    }
                                    else {
                                        Image("ghone")
                                            .resizable()
                                            .scaledToFit()
                                            .offset(y: isPopping ? 40 : screenHeight * 0.43)
                                    }
                                    
                                }
                            } else {
                                ZStack{
                                    if (isWink == true) {
                                        Image("sleepSassyGhone")
                                            .resizable()
                                            .scaledToFit()
                                            .offset(y: 40)
                                    }
                                    else {
                                        Image("sassyGhone")
                                            .resizable()
                                            .scaledToFit()
                                            .offset(y: isPopping ? 40 : screenHeight * 0.43)
                                    }
                                    
                                }
                            }
                            
                        }
                        .frame(height: screenHeight)
                        .onTapGesture {
                            withAnimation(.spring(dampingFraction: 0.5)){
                                if (currentIndex < 3){
                                    isPopping = true
                                    currentIndex += 1
                                }
                                
                                if (currentIndex == 4){
                                    currentIndex = 0
                                    isPopping = false
                                }
                            }
                            
                        }
                        
                        VStack {
                            switch(currentIndex){
                            case 0:
                                Sleep(namespace: namespace, isPopping: $isPopping, username: $username)
                                    
                            case 1:
                                AwakeTalk(namespace: namespace, personality: $personality)
                                    .onAppear {
                                        startTimer()
                                    }
                            case 2:
                                Awake(namespace: namespace, isPopping: $isPopping, username: $username, personality: $personality)
                                
                            case 3:
                                AwakeNext(namespace: namespace, personality: $personality)
                            default:
                                Sleep(namespace: namespace, isPopping: $isPopping, username: $username)
                            }
                            
                        }
                        
                    }
                    .background {
                        Color.white
                    }

                    .edgesIgnoringSafeArea(.all)
        }
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 4.9, repeats: true) { _ in
            withAnimation() {
                isWink.toggle()
            }
         

        }

        
    }
}

struct Awake: View {
    let namespace : Namespace.ID
    @Binding var isPopping: Bool
    @Binding var username: String
    @Binding var personality: String
    
    var body: some View {
        VStack {
            VStack(spacing: 10){
                Text(personality == "nice" ? "Hi, \(username)." : "Oh, it’s you, \(username).")
                    .font(.system(size: 30, weight: .bold))
                Text(personality == "nice" ? "Don't worry, you are not alone. I am here to support you." : "You're scared? Geez, ghosts aren't real, but your ability to jump to conclusions is top-notch.")
                    
            }
            .foregroundColor(.lightTeal90)
            .multilineTextAlignment(.center)
            .frame(width: screenWidth*3/4)
            Spacer()
        }
        .padding(.vertical, 100)
        .frame(height: screenHeight*5/6)
        .animation(.easeInOut, value: 0.5)
    }
}

struct Sleep: View {
    let namespace : Namespace.ID
    @Binding var isPopping: Bool
    @Binding var username: String
    
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
            .opacity(isPopping ? 0 : 1)
        }
        .frame(height: screenHeight*5/6)
        .animation(.easeInOut, value: 0.5)
    }
}

struct AwakeNext: View {
    let namespace : Namespace.ID
    @Binding var personality: String
    var body: some View {
        VStack {
            Text(personality == "nice" ? "Let's find ways to distract and occupy your mind.." : "It's not like I want to help you, but I guess we could explore some activities to occupy your mind for a while.")
                .foregroundColor(.lightTeal90)
                .multilineTextAlignment(.center)
                .padding(.vertical, 100)
                .frame(width: screenWidth*4/5)
            Spacer()
            VStack{
                PrimaryButton(title: "Let's go!") {
                    
                }
            }
            
        }
        .padding(.vertical, 100)
        .frame(height: screenHeight)
        .animation(.easeInOut, value: 0.5)
    }
}

struct AwakeTalk: View {
    let namespace: Namespace.ID
    @Binding var personality: String
    
    var body: some View {
        VStack(spacing: 10){
            Text(personality == "nice" ? "Let's talk!" : "OK, let’s talk.")
                .font(.system(size: 34, weight: .bold))
            Text(personality == "nice" ? "Go ahead, I’m all ears for you." : "I’ll listen when I care.")
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
