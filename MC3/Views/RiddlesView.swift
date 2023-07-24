//
//  RiddlesScreen.swift
//  MC3
//
//  Created by Safik Widiantoro on 23/07/23.
//

import SwiftUI



struct RiddlesView: View {
    @State private var isGuessed = false
    var body: some View {
        VStack (spacing: 20){
            Text("Guess the answer!")
                .fontWeight(.bold)
                .font(.system(size: 24))
            Text("What did the ocean say to the beach?")
                .padding(.horizontal, 20)
            
            VStack{
                Text("Answer :")
                Text("Nothing, it just waved")
                    .bold()
            }.frame(maxWidth: .infinity)
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.purple30, lineWidth: 10)
                    .foregroundColor(Color.myPurple)
                    .frame(width: screenWidth * 0.56, height: screenHeight * 0.12)
                    .background(Color.purple10)
            }.opacity(isGuessed ? 1: 0)
                .padding(.top,40)

            
            Image(isGuessed ? "ghone" : "sleepGhone")
                .resizable()
                .scaledToFill()
                .offset(y: screenHeight * 0.2)
        }
        .padding(.top, screenHeight * 0.1)
        .frame(maxWidth: screenWidth, maxHeight: screenHeight)
        .onTapGesture {
            withAnimation{
                isGuessed.toggle()
            }
            
        }
    }
}

struct RiddlesAnsweredView: View {
    var body: some View {
        VStack{
            Text("Guess the answer!")
                .fontWeight(.bold)
                .font(.system(size: 24))
                .padding(.vertical, 10)
            Text("What did the ocean say to the beach?")
            Image("sleepGhone")
                .resizable()
                .scaledToFit()
                .offset(y: screenWidth * 0.42)
        }
    }
}


struct RiddlesView_Previews: PreviewProvider {
    static var previews: some View {
        RiddlesView()
    }
}
