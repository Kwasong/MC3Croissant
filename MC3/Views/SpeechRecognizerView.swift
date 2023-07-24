//
//  SpeechRecognizerView.swift
//  MC3
//
//  Created by Safik Widiantoro on 21/07/23.
//

import SwiftUI


struct SpeechRecognizerView: View {
    @ObservedObject var speechRecognizer = SpeechRecognizer()

    var body: some View {
        VStack {
            Text(speechRecognizer.recognizedText)
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .animation(.default, value: speechRecognizer.recognizedText)
            
            Button(action: speechRecognizer.toggleRecognition) {
                Text(speechRecognizer.isRecognizing ? "Stop Recognition" :  "Start Recognition")
            }
            .padding()
            .foregroundColor(.white)
            .fixedSize()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(speechRecognizer.isRecognizing ? .red : .green)
            )
        }

        .padding()
        .animation(.default, value: speechRecognizer.isRecognizing)
    }
}
