//
//  MC3App.swift
//  MC3
//
//  Created by Wahyu Alfandi on 15/07/23.
//

import SwiftUI

@main
struct MC3App: App {
   
    @StateObject var router = Router()
//    @StateObject var musicViewModel = MusicPlayerViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                ContentView()
                    .navigationDestination(for: Route.self) { route in
                        switch(route){
                        case .onboarding:
                            OnboardingView()
                            
                        case .musicPlayer(let album):
                            MusicPlayerView(album: album)
                        case .assestmentView(let method):
                            AssestmentView(lastMethod: method)
                        case .result(let method):
                            ResultView(lastMethod: method)
                        case .test(let data):
                            Text("\(data)")
                        default:
                            Text("404")
                        }
                    }
            }
            .environmentObject(router)
//            .environmentObject(musicViewModel)
        }
    }
}
