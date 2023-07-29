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
    
    let lastMethod: Method
    var isStillScared: Bool = false
    
    var body: some View {
        VStack{
            if personality == "friendly"{
                friendly
            } else{
                sassy
            }
            
            PrimaryButton(title: "Continue") {
                switch lastMethod {
                case .breathing:
                    router.push(.albumListView)
                case .musicPlayer:
                    router.push(.riddleView)
                default:
                    router.push(.mainScreenView)
                }
            }
            .padding(.top, 72)
            
            Button {
                
            } label: {
                Text("End Session")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.teal60)
            }
            .padding(.top, 14)
            
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
        .navigationBarBackButtonHidden(true)
    }
    
    var sassy: some View{
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
    }
}


struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(personality: "friendly", lastMethod: .chat)
    }
}
