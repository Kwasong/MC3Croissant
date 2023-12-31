//
//  MC3App.swift
//  MC3
//
//  Created by Wahyu Alfandi on 15/07/23.
//

import SwiftUI

@main
struct MC3App: App {
    @AppStorage("personality") var personality: String = "friendly"
    @StateObject var router = Router()
    @StateObject var musicViewModel = MusicViewModel()

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
                        case .breathingView:
                            BreathingView()
                        case .assestmentView:
                            AssestmentView()
                        case .result(let isStillscared):
                            ResultView( isStillScared: isStillscared)
                        case .test(let data):
                            Text("\(data)")
                        case .comfortingView:
                            ComfortingView()
                        case .albumListView:
                            AlbumListView()
                        case .riddleView:
                            RiddlesView()
                        case .mainScreenView:
                            MainScreenView()
                        default:
                            Text("404")
                        }
                    }
            }
            .background(Color.white)
            .environmentObject(router)
            .environmentObject(musicViewModel)
            .colorScheme(.light)
        }
    }
}
