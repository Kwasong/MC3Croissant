//
//  OnboardingView.swift
//  MC3
//
//  Created by Wahyu Alfandi on 15/07/23.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("isShowingOnboarding") var isShowingOnboarding: Bool = true
    @EnvironmentObject var router: Router
    
    @StateObject private var viewModel = OnboardingViewModel()
    var body: some View {
        VStack{
            switch(viewModel.index){
            case 0:
                first
            case 1:
                second
            case 2:
                third
            default:
                first
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}

extension OnboardingView {
    private var first: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            Image("ghone")
            Text("Hey! I’m Ghone")
                .font(.system(size: 20, weight: .bold))
                .padding(.top, 73)
            
            Text("I’m here to help you reduce your\nfear and get some inner peace")
                .font(.system(size: 16, weight: .light))
                .multilineTextAlignment(.center)
                .padding(.top, 14)
            
            NextButton {
                withAnimation(.easeIn(duration: 0.6)){
                    viewModel.index = 1
                }
                
            }
            .padding(.top, 80)
            
            Spacer()
        }
    }
    
    private var second: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            Image("ghone")
            Text("I'm curious how should I\naddress you?")
                .multilineTextAlignment(.center)
                .font(.system(size: 20, weight: .semibold))
                .padding(.top, 55)
            
            GeneralTextField(text: $viewModel.name, placeholder: "Type your nickname here")
                .padding(.top, 34)

            
            NextButton {
                viewModel.validateName()
                
                if !viewModel.isNameError{
                    withAnimation(.easeIn(duration: 0.6)){
                        viewModel.index = 2
                    }
                } else {
                    //TODO: add action when name is invalid
                    print(viewModel.name)
                    print("name is invalid")
                }
                
                
                
            }
            .padding(.top, 52)
            
            Spacer()
        }
    }
    
    private var third: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            Text("How would you like me to act during our conversation as you navigate this app?")
                .multilineTextAlignment(.center)
                .font(.system(size: 20, weight: .semibold))
                .padding(.top, 55)
                .padding(.horizontal, 54)
            
            HStack(spacing: 82){
                VStack{
                    Image("nice")
                        .overlay {
                            Circle().stroke(Color("teal"), lineWidth: viewModel.personality == "nice" ? 10 : 2)
                                .frame(width: 100, height: 100)
                        }
                        .scaleEffect(viewModel.personality == "nice" ? 1.2 : 1)
                    Text("Nice")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(viewModel.personality == "nice" ? .myTeal : .neutral)
                        .padding(.top, viewModel.personality == "nice" ? 14 : 7)
                }
                .onTapGesture {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)){
                        viewModel.personality = "nice"
                    }
                }
                VStack{
                    Image("sassy")
                        .overlay {
                            Circle().stroke(Color("teal"), lineWidth: viewModel.personality == "sassy" ? 10 :2)
                                .frame(width: 100, height: 100)
                        }
                        .scaleEffect(viewModel.personality == "sassy" ? 1.2 : 1)
                    Text("Sassy")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(viewModel.personality == "sassy" ? .myTeal : .neutral)
                        .padding(.top, viewModel.personality == "sassy" ? 14 : 7)
                        
                }
                .onTapGesture {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)){
                        viewModel.personality = "sassy"
                    }
                    
                }
                    
                
            }
            .padding(.top, 60)
            
            NextButton {
                viewModel.validatePersonality()
                
                if !viewModel.isPersonalityError{
                    withAnimation (.easeIn(duration: 0.6)){
                        isShowingOnboarding = false
                    }
                } else {
                    //TODO: add action when name is invalid
                    print(viewModel.personality)
                    print("name is invalid")
                }
                
                
            }
            .padding(.top, 52)
            
            Spacer()
        }
    }
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
