//
//  ContentView.swift
//  MC3
//
//  Created by Wahyu Alfandi on 16/07/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isShowingOnboarding") var isShowingOnboarding: Bool = true
    var body: some View {
        if isShowingOnboarding {
//            AlbumListView()
//                .onAppear{
//                    guard let apiKey: String = Bundle.main.infoDictionary?["API_KEY"] as? String else {return}
//                    print(apiKey)
//                }
            RddleView()
        } else {
            VStack{
                BreathingView()
            }
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
