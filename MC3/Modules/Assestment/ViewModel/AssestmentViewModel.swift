//
//  AssestmentViewModel.swift
//  MC3
//
//  Created by Wahyu Alfandi on 22/08/23.
//

import Foundation

class AssestmentViewModel: ObservableObject {
    @Published var feeling = "scared"
    @Published var isStillScared: Bool = false
}
