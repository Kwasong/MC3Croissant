//
//  OnboardingViewModels.swift
//  MC3
//
//  Created by Wahyu Alfandi on 16/07/23.
//

import Foundation

@MainActor final class OnboardingViewModel: ObservableObject {
    @Published  var index: Int = 0
    @Published  var name: String = ""
    
    
}
