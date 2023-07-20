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
                        case .test(let data):
                            Text("\(data)")
                        default:
                            Text("404")
                        }
                    }
            }
            .environmentObject(router)
        }
    }
}
