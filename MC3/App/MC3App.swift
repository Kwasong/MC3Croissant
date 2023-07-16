//
//  MC3App.swift
//  MC3
//
//  Created by Wahyu Alfandi on 15/07/23.
//

import SwiftUI

@main
struct MC3App: App {
    @AppStorage("isShowingOnboarding") var isShowingOnboarding: Bool = true
    
    @State var path: NavigationPath = NavigationPath()
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                if isShowingOnboarding {
                    OnboardingView()
                } else {
                    VStack{
                        Text("Main Screen here")
                    }
                }
                
            }
        }
    }
}
