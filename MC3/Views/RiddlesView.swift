//
//  RiddlesScreen.swift
//  MC3
//
//  Created by Safik Widiantoro on 23/07/23.
//

import SwiftUI

struct RiddlesView: View {
    @State private var isGuessed = false
    var riddles: RiddlesModel?
    var body: some View {
        VStack (spacing: 0){
            VStack(spacing: 60) {
                VStack(spacing: 20){
                    Text("Guess the answer!")
                        .fontWeight(.bold)
                        .font(.system(size: 24))
                    Text("What did the ocean say to the beach?")
                        .font(.system(size: 18))
                }
                .padding(.top, 100)
                VStack {
                    Text("Answer :")
                    Text("Nothing, it just waved")
                        .bold()
                }
                .multilineTextAlignment(.center)
                .frame(maxWidth: screenWidth*3/4)
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.purple30, lineWidth: 6)
                        .foregroundColor(Color.myPurple)
                        .frame(width: screenWidth * 0.56, height: 85)
                        .background(Color.purple10)
                }
                .opacity(isGuessed ? 1: 0)

                HStack {
                    ShuffleButton {
                        
                    }
                    Spacer()
                    NextButton {
                        
                    }
                }
                .frame(width: screenWidth*1/2)
                .opacity(isGuessed ? 1 : 0)
            }
            Image(isGuessed ? "ghone" : "sleepGhone")
                .resizable()
                .scaledToFill()
                .offset(y: screenHeight * 0.1)
            
        }
        .foregroundColor(.lightTeal90)
        .background(Color.white)
//        .padding(.top, screenHeight * 0.1)
        .frame(maxWidth: screenWidth, maxHeight: screenHeight)
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
            .preferredColorScheme(.dark)
    }
}
