//
//  RddleView.swift
//  MC3
//
//  Created by Sha Nia Siahaan on 25/07/23.
//

import SwiftUI

struct RddleView: View {
    @State private var riddel: [Riddles] = []
    @State private var isLoading = false
    @State var currentindex: Int = 0
    var randomNum: Int = Int.random(in: 0..<3)
    var rdll = riddle
    var body: some View {
        VStack {
            Text("\(riddle[currentindex].question)")
            NextButton {
                var randomNum: Int = Int.random(in: 0..<5)
                currentindex = randomNum
            }
        }
        
    }
}
struct RddleView_Previews: PreviewProvider {
    static var previews: some View {
        RddleView()
            .preferredColorScheme(.dark)
    }
}

