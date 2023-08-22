//
//  RiddlesViewModel.swift
//  MC3
//
//  Created by Wahyu Alfandi on 22/08/23.
//

import Foundation

class RiddlesViewModel: ObservableObject {
    @Published var isGuessed = true
    @Published var currentindex: Int = 0
}
