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
                .font(.system(size: 20, weight: .semibold))
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
                            Circle().stroke(Color("teal"), lineWidth: feeling == "scared" ? 10 :2)
                                .frame(width: 100, height: 100)
                        }
                        .scaleEffect(feeling == "scared" ? 1.2 : 1)
                    Text("Scared")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(feeling == "scared" ? .myTeal : .neutral)
                        .padding(.top, feeling == "scared" ? 14 : 7)
                    
                }
                .onTapGesture {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)){
                        feeling = "scared"
                    }
                    
                }
                
                VStack{
                    Image("relaxed")
                        .overlay {
                            Circle().stroke(Color("teal"), lineWidth: feeling == "relaxed" ? 10 : 2)
                                .frame(width: 100, height: 100)
                        }
                        .scaleEffect(feeling == "relaxed" ? 1.2 : 1)
                    Text("Relaxed")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(feeling == "relaxed" ? .myTeal : .neutral)
                        .padding(.top, feeling == "relaxed" ? 14 : 7)
                }
                .onTapGesture {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)){
                        feeling = "relaxed"
                    }
                }
            }
            .padding(.top, 110)
            
            PrimaryButton(title: "Continue") {
                router.push(.result(lastMethod: .breathing))
            }.padding(.top, 170)
                
        }
        .navigationBarBackButtonHidden(true)
    }
}


struct AudioAssestmentView_Previews: PreviewProvider {
    static var previews: some View {
        AssestmentView(lastMethod: .chat)
    }
}
