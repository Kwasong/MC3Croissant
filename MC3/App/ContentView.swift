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
//            AlbumListView()
            ComfortingView()
                
        } else {
            ComfortingView()
//                .task {
//                    do {
//                        let data = try await ElevenLabsService.sharedInstance.fetchTextToSpeech(text: "Can you help me please?")
//                        print(data)
//                    }catch{
//                        print(error.localizedDescription)
//                    }
//
//
//                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MusicViewModel())
    }
}
