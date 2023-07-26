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
    
    var body: some View {
        NavigationStack{
                    ZStack{
                        VStack{
                            Spacer()
                            ZStack{
                                Image("ghone")
                                    .resizable()
                                    .scaledToFit()
                                    .offset(y: isPopping ? 40 : screenHeight * 0.43)
                            }
                        }
                        .frame(width: screenWidth, height: screenHeight)
                        .onTapGesture {
                            withAnimation(.spring(dampingFraction: 0.5)){
                                if (currentIndex < 3){
                                    isPopping = true
                                    currentIndex += 1
                                }
                                
                                if (currentIndex == 3){
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
                                Awake(namespace: namespace, isPopping: $isPopping, username: $username)
                            case 2:
                                AwakeNext(namespace: namespace)
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
}

struct Awake: View {
    let namespace : Namespace.ID
    @Binding var isPopping: Bool
    @Binding var username: String
    
    var body: some View {
        VStack {
            VStack(spacing: 10){
                Text("Hi, \(username).")
                    .font(.system(size: 30, weight: .bold))
                Text("Don't worry, you are not alone. I am here to support you.")
                    
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
    
    var body: some View {
        VStack {
            Text("Let's find ways to distract and occupy your mind..")
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

struct ComfortingView_Previews: PreviewProvider {
    static var previews: some View {
        ComfortingView()
    }
}
