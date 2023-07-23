//
//  ComfortingView.swift
//  MC3
//
//  Created by Sha Nia Siahaan on 22/07/23.
//

import SwiftUI

let screenHeight = UIScreen.main.bounds.height
let screenWidth = UIScreen.main.bounds.width

struct ComfortingView: View {
    @Namespace var namespace
    
    @State var username: String = "Shan"
    @State var isPopping: Bool = false
    @State var currentIndex: Int = 0
    
    var body: some View {
        NavigationStack{
                    ZStack{
                        Color.white
                        VStack{
                            Spacer()
                            ZStack{
                                Image("ghone")
                                    .resizable()
                                    .scaledToFit()
                                    .offset(y: isPopping ? 40 : screenHeight * 0.42)
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
                                print(currentIndex)
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
                        VStack(alignment: .trailing){
                            HStack{
                                Spacer()
                                ToggleButton()
                            }
                            Spacer()
                        }
                        .frame(width: screenWidth, height: screenHeight)
                    }
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
        .frame(height: screenHeight*4/5)
    }
}

struct Sleep: View {
    let namespace : Namespace.ID
    @Binding var isPopping: Bool
    @Binding var username: String
    
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
    
    var body: some View {
        VStack {
            Text("Let's find ways to distract and occupy your mind..")
                .foregroundColor(.lightTeal90)
                .multilineTextAlignment(.center)
                .frame(width: screenWidth*3/4)
            Spacer()
            
        }
        .padding(.vertical, 100)
        .frame(height: screenHeight*3/4)
    }
}

struct ComfortingView_Previews: PreviewProvider {
    static var previews: some View {
        ComfortingView()
    }
}
