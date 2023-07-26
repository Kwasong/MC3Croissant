//
//  ResultView.swift
//  MC3
//
//  Created by Wahyu Alfandi on 21/07/23.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var router: Router
    let lastMethod: Method
    var body: some View {
        VStack{
            Text("That’s good")
                .font(Font.system(size: 24, weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundColor(.neutral)
            
            Text("Remember, it's okay to feel scared, but don't forget to celebrate these moments of relief, for they are proof of your resilience and progress.\n\nWe still have another method that you can try to reduce your fear.")
                .font(.system(size: 16))
                .foregroundColor(.neutral)
                .multilineTextAlignment(.leading)
                .padding(.horizontal,40)
                .padding(.top, 26)
            
            PrimaryButton(title: "Continue") {
                switch lastMethod {
                case .comforting:
                    router.push(.breathingView)
                case .breathing:
                    router.push(.albumListView)
                case .musicPlayer:
                    router.push(.riddleView)
                default:
                    router.push(.breathingView)
                }
            }.padding(.top, 314)
            
            Button{
            }label: {
                Text("End Session")
                    .foregroundColor(.teal60)
            }.padding(.top, 11)

            
        }
        
        .navigationBarBackButtonHidden(true)
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(lastMethod: .breathing)
    }
}
