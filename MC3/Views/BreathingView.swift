//
//  BreathingView.swift
//  MC3
//
//  Created by Safik Widiantoro on 19/07/23.
//

import SwiftUI

struct BreathingView: View {
    @State private var isAnimating = false
    @State private var animationStage = 0
    @State private var loopCount = 0
    @EnvironmentObject var router: Router
    
    private var animationText: String {
        switch animationStage {
        case 0:
            return "Breathe In"
        case 1:
            return "Hold"
        case 2:
            return "Breathe Out"
        default:
            return "Breathe In"
        }
    }
    
    var body: some View {
        VStack(spacing: 20){
            HStack{
                Button{
                    router.pop()
                }label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .foregroundColor(.teal50)
                }
                Spacer()
                Text("Skip")
                    .foregroundColor(.teal50)
                    .bold()
            }
            Spacer()
            
            Text("Let’s practice deep breathing and relaxation techniques to calm your mind.")
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
                .onTapGesture {
                    router.push(.riddleView)
                }
            
            ZStack{
                Circle()
                    .fill(Color.myPurple.opacity(0.25))
                    .frame(width: 350, height: 350)
                    .opacity(self.isAnimating ? 1 : 0)

                Circle()
                    .fill(Color.myPurple.opacity(0.35))
                    .frame(width: 250, height: 250)
                    .opacity(self.isAnimating ? 1 : 0)

                Circle()
                    .fill(Color.myPurple.opacity(0.45))
                    .frame(width: 150, height: 150)
                    .opacity(self.isAnimating ? 1 : 0)
                
                Image("ghone")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 83)
                    .scaleEffect(self.isAnimating ? 1 : 0)
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.startAnimating()
                }
            }
            
            withAnimation{
                Text(animationText)
                    .font(.system(size: 30, design: .default))
                    .bold()
            }
            
            HStack{
                if animationStage == 2 && loopCount == 3 {
                    withAnimation(Animation.easeInOut){
                        Button {
                            self.repeatBreathe()
                        }label: {
                            Circle()
                                .foregroundColor(Color.purple30)
                                .overlay(Image(systemName: "arrow.counterclockwise"))
                                .foregroundColor(Color.white)
                                .frame(maxWidth: 40)
                        }
                    }
                    
                }
                
                
                Button {
                    
                }label: {
                    Circle()
                        .foregroundColor(Color.purple30)
                        .overlay(Image(systemName: "chevron.right"))
                        .foregroundColor(Color.white)
                        .frame(maxWidth: 40)
                }
                
            }
            
            
        }
        .padding(27)
        .navigationBarBackButtonHidden()
    }
    
    
    private func repeatBreathe() {
        self.startAnimating()
        self.loopCount = 0
    }
    
    
    private func startAnimating() {
        withAnimation(Animation.easeInOut(duration: 4)) {
            self.isAnimating = true
        }
        self.animationStage = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.animationStage = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                withAnimation(Animation.easeInOut(duration: 8)) {
                    self.isAnimating = false
                }
                self.animationStage = 2
                
                self.loopCount += 1
                
                if self.loopCount < 3 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                        self.startAnimating()
                        self.animationStage = 0
                    }
                }
            }
            
        }
        
    }
    
}

struct BreathingView_Previews: PreviewProvider {
    static var previews: some View {
        BreathingView()
    }
}
