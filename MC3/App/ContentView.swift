//
//  ContentView.swift
//  MC3
//
//  Created by Wahyu Alfandi on 16/07/23.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @AppStorage("isShowingOnboarding") var isShowingOnboarding: Bool = true
    @State var audioPlayer: AVAudioPlayer?
    
    
    var body: some View {
        if isShowingOnboarding {
            AlbumListView()
                .onAppear{
                    guard let apiKey: String = Bundle.main.infoDictionary?["API_KEY"] as? String else {return}
                    print(apiKey)
                }
        } else {
            VStack{
                MainScreenView()
            }
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MusicViewModel())
    }
}
