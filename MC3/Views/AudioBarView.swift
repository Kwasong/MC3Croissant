//
//  AudioBarView.swift
//  MC3
//
//  Created by Safik Widiantoro on 20/07/23.
//

import SwiftUI

let numberOfSamples: Int = 10

struct AudioBarView: View {
    // 1
    @ObservedObject private var mic = MicrophoneMonitor(numberOfSamples: numberOfSamples)
    
    // 2
    private func normalizeSoundLevel(level: Float) -> CGFloat {
        let level = max(0.2, CGFloat(level) + 50) / 2 // between 0.1 and 25
        
        return CGFloat(level * (300 / 25)) // scaled to max at 300 (our height of our bar)
    }
    
    var body: some View {
        VStack {
             // 3
            HStack(spacing: 4) {
                 // 4
                ForEach(mic.soundSamples, id: \.self) { level in
                    BarView(value: self.normalizeSoundLevel(level: level))
                }
            }
        }
    }
}

struct BarView: View {
   // 1
    var value: CGFloat

    var body: some View {
        ZStack {
           // 2
            RoundedRectangle(cornerRadius: 25)
                    .fill(.indigo.gradient)
                .frame(width: (UIScreen.main.bounds.width - CGFloat(numberOfSamples) * 4) / CGFloat(numberOfSamples), height: value)
        }
    }
}

struct AudioBarView_Previews: PreviewProvider {
    static var previews: some View {
        AudioBarView()
    }
}
