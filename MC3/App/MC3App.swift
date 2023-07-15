//
//  MC3App.swift
//  MC3
//
//  Created by Wahyu Alfandi on 15/07/23.
//

import SwiftUI

@main
struct MC3App: App {
    
    @State var path : NavigationPath = NavigationPath()
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                OnboardingView()
            }
        }
    }
}
