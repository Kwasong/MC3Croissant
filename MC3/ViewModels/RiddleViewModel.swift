//
//  RiddleViewModel.swift
//  MC3
//
//  Created by Wahyu Alfandi on 30/07/23.
//

import Foundation
import SwiftUI

class RiddleViewModel: ObservableObject{
    @Published var riddles: [Riddle] = dummyRiddles
    @Published var index = 0
    @Published var isGuessed: Bool = false
    @Published var isLoading = false
    @Published var timer: Timer?
    @Published var remainingSeconds = 3
    
    init(){
        index = Int.random(in: 0..<riddles.count)
    }
    
    func nextRiddle(){
        isGuessed = false
        
        if index < riddles.count {
            index += 1
        }else{
            index = 0
        }
    }
    
    func shuffle(){
        index = Int.random(in: 0...riddles.count - 1)
        isGuessed = false
    }
    
//    func setTimerForAnswer(){
//        remainingSeconds = 3
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false){ _ in
//            if self.remainingSeconds > 0 {
//                self.remainingSeconds -= 1
//            }else{
//                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)){
//                    self.isGuessed = true
//                }
//            }
//        }
//    }
    
    func setTimerForAnswer(){
        timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: false){ _ in
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)){
                self.isGuessed = true
            }
        }
    }
}
