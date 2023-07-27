//
//  AudioAssestmentView.swift
//  MC3
//
//  Created by Wahyu Alfandi on 21/07/23.
//

import SwiftUI

struct AssestmentView: View {
    @EnvironmentObject var router: Router
    let lastMethod: Method
    @State var feeling = ""
    
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
                    }
                }
            }
            .padding(.top, 110)
            
            PrimaryButton(title: "Continue") {
                switch lastMethod {
                case .breathing:
                    router.push(.albumListView)
                case .musicPlayer:
                    router.push(.riddleView)
                default:
                    router.push(.mainScreenView)
                }
            }.padding(.top, 170)
                
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
    }
}


struct AudioAssestmentView_Previews: PreviewProvider {
    static var previews: some View {
        AssestmentView(lastMethod: .chat)
    }
}
