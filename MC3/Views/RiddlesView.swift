//
//  RiddlesScreen.swift
//  MC3
//
//  Created by Safik Widiantoro on 23/07/23.
//

import SwiftUI

struct RiddlesView: View {
    @EnvironmentObject var router: Router
    @StateObject var viewModel = RiddleViewModel()
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
                .opacity(viewModel.isGuessed ? 1.0 : 0.0)
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
                
                if viewModel.remainingSeconds == 0 {
                    RiddlesAnswerView(viewModel: viewModel)
                    HStack(spacing: 100) {
                        ShuffleButton {
                            viewModel.shuffle()
                            viewModel.setTimerForAnswer()
                        }
                        NextButton {
                            viewModel.nextRiddle()
                            viewModel.setTimerForAnswer()
                        }
                    }
                    .opacity(viewModel.isGuessed ? 1 : 0)
                } else{
                    Text(viewModel.remainingSeconds)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.neutral)
                        .frame(height: 170)
                }
                
                
            }
            
            if (personality == "nice") {
                Image(viewModel.isGuessed ? "ghone" : "sleepGhone")
                    .resizable()
                    .scaledToFill()
                    .offset(y: screenHeight * 0.1)
            } else {
                Image(viewModel.isGuessed ? "sassyGhone" : "sassyGhoneBlink")
                    .resizable()
                    .scaledToFill()
                    .offset(y: screenHeight * 0.1)
            }
            
        }
        .navigationBarBackButtonHidden()
        .padding(.top, 150)
        .foregroundColor(.lightTeal90)
        .background(Color.white)
        .onAppear{
            viewModel.setTimerForAnswer()
        }
    }
}

struct RiddlesAnswerView: View {
    @ObservedObject var viewModel: RiddleViewModel
    var body: some View {
        VStack(spacing: 50) {
            Text("\(viewModel.riddles[viewModel.index].question)")
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            VStack(spacing: 5) {
                Text("Answer :")
                Text("\(viewModel.riddles[viewModel.index].answer)")
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
            .opacity(viewModel.isGuessed ? 1: 0)
        }
        .frame(width: screenWidth*3/4)
        
    }
}

struct RiddlesView_Previews: PreviewProvider {
    static var previews: some View {
        RiddlesView()
    }
}
