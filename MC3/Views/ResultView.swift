//
//  ResultView.swift
//  MC3
//
//  Created by Wahyu Alfandi on 21/07/23.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var router: Router
    @AppStorage("personality") var personality: String = ""
    @State var audioPlayer = AudioPlayer()
    let isStillScared: Bool
    
    var body: some View {
        VStack{
            if personality == "friendly"{
                friendly
            } else{
                sassy
            }
            
            PrimaryButton(title: router.lastMethod == .fromMain ? "Done": "Continue") {
                
                switch router.lastMethod {
                case .breathing:
                    router.push(.albumListView)
                case .musicPlayer:
                    router.push(.riddleView)
                case .fromMain:
                    router.toRoot()
                default:
                    router.toRoot()
                }
                
                audioPlayer.stopAudio()
            }
            .padding(.top, 72)
            
            if router.lastMethod != .fromMain{
                Button {
                    audioPlayer.stopAudio()
                    router.toRoot()
                } label: {
                    Text("End Session")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.teal60)
                }
                .padding(.top, 14)
            }
        }
        .padding(.horizontal, 40)
    }
}

extension ResultView{
    var friendly: some View{
        VStack{
            Text(isStillScared ? "It’s okay" : "That’s good")
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.neutral)
            
            Text(
                isStillScared ?
                "It's perfectly natural to feel scared, and your feelings are valid. It's okay to take your time to overcome this fear.\n\nDon’t worry, we still have another method that you can try to reduce your fear." : "Remember, it's okay to feel scared, but don't forget to celebrate these moments of relief, for they are proof of your resilience and progress.\n\nWe still have another method that you can try to reduce your fear."
            )
            .font(.system(size: 16))
            .foregroundColor(.neutral)
            .padding(.top, 26)
            
            Image(isStillScared ? "ghone-wink" : "ghone-relaxed")
                .resizable()
                .scaledToFill()
                .frame(width: isStillScared ? 140 : 214, height: isStillScared ? 190 : 207)
                .padding(.top, 72)
        }
        .onAppear{
            print(isStillScared)
            if isStillScared{
                audioPlayer.prepareAudio(track: "friendly-scared")
                audioPlayer.resumeAudio()
                return
            }
            audioPlayer.prepareAudio(track: "friendly-relaxed")
            audioPlayer.resumeAudio()
           
        }
        .navigationBarBackButtonHidden(true)
    }
    
    var sassy: some View{
        VStack{
            Text(isStillScared ? "Geez.." : "Tch, finally..")
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.neutral)
            
            Text(
                isStillScared ?
                "That’s why you should stop listening to those spine-chilling ghost stories your friends tell you.\n\nIt’s not like I care or anything, but let’s try another method for now. But don't go around telling everyone how \"nice\" I am!" : "You better not tell anyone I said this, but, um, feeling scared is, well, a part of being human. It’s a natural reaction. But if it gets worse, just ask for help.\n\nAnyway, we still have another method that you can try to reduce your fear. "
            )
            .font(.system(size: 16))
            .foregroundColor(.neutral)
            .padding(.top, 26)
            
            Image(isStillScared ? "upset" : "finally")
                .resizable()
                .scaledToFill()
                .frame(width: isStillScared ? 140 : 214, height: isStillScared ? 190 : 207)
                .padding(.top, 72)
        }
        .onAppear{
            if isStillScared{
                audioPlayer.prepareAudio(track: "sassy-scared")
                audioPlayer.resumeAudio()
                return
            }
            audioPlayer.prepareAudio(track: "sassy-relaxed")
            audioPlayer.resumeAudio()
           
        }
        .navigationBarBackButtonHidden(true)
    }
}


struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(personality: "friendly", isStillScared: false)
    }
}
