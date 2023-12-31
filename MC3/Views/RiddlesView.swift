//
//  RiddlesScreen.swift
//  MC3
//
//  Created by Safik Widiantoro on 23/07/23.
//

import SwiftUI

struct RiddlesView: View {
    @State private var isGuessed = true
    @State var currentindex: Int = 0
    @EnvironmentObject var router: Router

    @State var personality: String = "sassy"
    var body: some View {
        VStack(spacing: 10){
            HStack {
                BackButton {
                    router.pop()
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 50)
                Spacer()
                Button {
                    if router.lastMethod != .fromMain{
                        router.lastMethod = .riddleView
                    }
                    router.push(.assestmentView)
                } label: {
                    Text(router.lastMethod == .fromMain ? "Done" : "Skip")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.teal55)
                }
                .padding(.horizontal, 30)
                
            }
            VStack {
                Text("Guess the answer!")
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                }
                .padding(.vertical, 20)
                .frame(height: 24)
            Spacer()
            VStack(spacing: 50){
                RiddlesAnswerView(isGuessed: $isGuessed, currentindex: $currentindex)
                HStack(spacing: 100) {
                    ShuffleButton {
                        currentindex = Int.random(in: 0..<5)
                        isGuessed.toggle()
                    }
                    NextButton {
                        
                        
                        //MARK: if berikut penting buat routing
                        if router.lastMethod != .fromMain{
                            router.lastMethod = .riddleView
                        }
                        
                        router.push(.assestmentView)
                    }
                }
                .opacity(isGuessed ? 1 : 0)
            }
            
            if (personality == "nice") {
                Image(isGuessed ? "ghone" : "sleepGhone")
                    .resizable()
                    .scaledToFill()
                    .offset(y: screenHeight * 0.1)
            } else {
                Image(isGuessed ? "sassyGhone" : "sassyGhoneBlink")
                    .resizable()
                    .scaledToFill()
                    .offset(y: screenHeight * 0.1)
            }
            
        }
        .navigationBarBackButtonHidden()
        .padding(.top, 150)
        .foregroundColor(.lightTeal90)
        .background(Color.white)
        .onTapGesture {
            withAnimation{
                isGuessed.toggle()
            }

        }
    }
}

struct RiddlesAnswerView: View {
    var answer: String = ""
    @Binding var isGuessed: Bool
    @Binding var currentindex: Int
    var body: some View {
        VStack(spacing: 50) {
            Text("\(riddle[currentindex].question)")
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
            VStack(spacing: 5) {
                Text("Answer :")
                Text("\(riddle[currentindex].answer)")
                    .bold()
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: screenWidth*3/4)
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.teal40, lineWidth: 6)
                    .foregroundColor(Color.teal10)
                    .frame(width: screenWidth * 0.56, height: 85)
                    .background(Color.purple10)
            }
            .opacity(isGuessed ? 1: 0)
        }
        .frame(width: screenWidth*3/4)
        
    }
}

struct RiddlesView_Previews: PreviewProvider {
    static var previews: some View {
        RiddlesView()
    }
}
