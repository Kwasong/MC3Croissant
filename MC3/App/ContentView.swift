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
                    ElevenLabsService.sharedInstance.fetchTextToSpeech(text: "the GPT family of models process text using tokens, which are common sequences of characters found in text. The models understand the statistical relationships between these tokens, and excel at producing the next token in a sequence of tokens.") { remoteResponse in
                        switch remoteResponse {
                        case .success(let data):
                            print("disini masuk success")
                            
                            do{
                                audioPlayer = try AVAudioPlayer(data: data)
                                audioPlayer?.prepareToPlay()
                                audioPlayer?.play()
                            }catch {
                                print("gagal play audio")
                            }
                            
                        case .failure(let failure):
                            print("failure")
                        }
                    }
                }
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
            .environmentObject(MusicViewModel())
    }
}
