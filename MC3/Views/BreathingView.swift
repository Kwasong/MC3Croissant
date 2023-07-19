//
//  BreathingView.swift
//  MC3
//
//  Created by Safik Widiantoro on 19/07/23.
//

import SwiftUI

struct BreathingView: View {
    @State var isBreathe = true
    @State var isAnimate = false
    
    var body: some View {
        VStack{
            Text("Let’s practice deep breathing and relaxation techniques to calm your mind.")
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 80)
            
            ZStack{
                Circle()
                    .fill(Color.blue.opacity(0.25))
                    .frame(width: 350, height: 350)
                    .scaleEffect(isAnimate ? 1 : 0)
                Circle()
                    .fill(Color.blue.opacity(0.35))
                    .frame(width: 250, height: 250)
                    .scaleEffect(isAnimate ? 1 : 0)
                Circle()
                    .fill(Color.blue.opacity(0.45))
                    .frame(width: 150, height: 150)
                    .scaleEffect(isAnimate ? 1 : 0)
                Image("ghone")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 83)
            }.onAppear {
                withAnimation(Animation.linear(duration: 4)
                    .repeatCount(2, autoreverses: true)
                )
                {
                    isAnimate.toggle()
                }
                
            }
            
            
            
            
            Text(isBreathe ? "Breathe in" : "Breathe out")
                .font(.system(size: 30, design: .monospaced))
                .bold()
                .italic()
        }
    }
}

struct BreathingView_Previews: PreviewProvider {
    static var previews: some View {
        BreathingView()
    }
}
