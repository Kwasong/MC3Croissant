//
//  OnboardingViewModels.swift
//  MC3
//
//  Created by Wahyu Alfandi on 16/07/23.
//

import Foundation

@MainActor final class OnboardingViewModel: ObservableObject {
    @Published var index: Int = 0
    @Published var name: String = ""
    @Published var personality: String = ""
    
    //validation
    @Published var isNameError: Bool = false
    @Published var isPersonalityError: Bool = false
    
    func validateName(){
        if name.isEmpty || name == ""{
            isNameError = true
        }
    }
    
    func validatePersonality(){
        if personality.isEmpty || personality == ""{
            isPersonalityError = true
        }
    }
}
