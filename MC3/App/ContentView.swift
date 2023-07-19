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
            OnboardingView()
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
