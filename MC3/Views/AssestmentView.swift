//
//  AudioAssestmentView.swift
//  MC3
//
//  Created by Wahyu Alfandi on 21/07/23.
//

import SwiftUI

struct AssestmentView: View {
    @EnvironmentObject var router: Router
    @AppStorage("personality") var personality: String = ""
    @State var feeling = "scared"
    @State var isStillScared:Bool = false
    @State var audioPlayer = AudioPlayer()
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("Let's see")
                .multilineTextAlignment(.center)
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.neutral)
                .padding(.top, 55)
                .padding(.horizontal, 54)
            
            Text("How are you feeling now after trying the latest method?")
                .multilineTextAlignment(.center)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.neutral)
                .padding(.top, 26)
                .padding(.horizontal, 54)
            
            HStack(spacing: 82){
                VStack{
                    Image("scared")
                        .overlay {
                            Circle().stroke(Color("teal"), lineWidth: feeling == "scared" ? 4 : 2)
                                .frame(width: 105, height: 105)
                        }
                        .scaleEffect(feeling == "scared" ? 1.2 : 1)
                    Text("Still scared")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.neutral)
                        .padding(.top, feeling == "scared" ? 20 : 7)
                    
                }
                .onTapGesture {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)){
                        feeling = "scared"
                        isStillScared = true
                    }
                    
                }
                
                VStack{
                    Image("relaxed")
                        .overlay {
                            Circle().stroke(Color("teal"), lineWidth: feeling == "relaxed" ? 4 : 2)
                                .frame(width: 105, height: 105)
                        }
                        .scaleEffect(feeling == "relaxed" ? 1.2 : 1)
                    Text("Relaxed")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.neutral)
                        .padding(.top, feeling == "relaxed" ? 20 : 7)
                }
                .onTapGesture {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)){
                        feeling = "relaxed"
                        isStillScared = false
                    }
                }
            }
            .padding(.top, 110)
            
            PrimaryButton(title: "Continue") {
                audioPlayer.stopAudio()
                print("scared \(isStillScared)" )
                router.push(.result(isStillScared: isStillScared))
            }
            .padding(.top, 170)
            .padding(.horizontal, 40)
                
        }
        .onAppear{
            if personality == "friendly"{
                audioPlayer.prepareAudio(track: "assestment-friendly")
                audioPlayer.resumeAudio()
            }else{
                audioPlayer.prepareAudio(track: "assestment-sassy")
                audioPlayer.resumeAudio()
            }
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
    }
}


struct AudioAssestmentView_Previews: PreviewProvider {
    static var previews: some View {
        AssestmentView()
    }
}
