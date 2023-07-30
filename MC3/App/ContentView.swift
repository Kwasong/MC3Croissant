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
            OnboardingView()
        } else {
            MainScreenView()
                .task{
                    do{
                        let data = try await OpenAIService.sharedInstance.sendMessage(params: OpenAIRequest(prompt: "Can you help me?"))
                    }catch{
                        print(error.localizedDescription)
                    }
                    
                    
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
