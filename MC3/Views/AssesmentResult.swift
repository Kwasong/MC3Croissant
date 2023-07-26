//
//  AssesmentResult.swift
//  MC3
//
//  Created by Sha Nia Siahaan on 26/07/23.
//

import SwiftUI

struct AssesmentResult: View {
//    @Binding var feeling: String
    var feeling = "relaxed"
    var body: some View {
        VStack {
            VStack {
                if (feeling == "scared") {
                    AssesmentResultScared()
                } else if (feeling == "relaxed") {
                    AssesmentResultRelaxed()
                } else {
                    AssesmentResultScared()
                        
                }
            }
            .frame(width: screenWidth*4/5)
            .foregroundColor(.lightTeal90)
            
            Image(feeling == "scared" ? "ghone-wink" : "ghone-relaxed")
                .padding(.vertical, 70)
            PrimaryButton(title: "Continue") {
                
            }
            Button {
                
            } label: {
                Text("End Session")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.teal60)
            }

        }
        .navigationBarBackButtonHidden(true)
    }
}

struct AssesmentResultScared: View {
    var body: some View {
        VStack(spacing: 25){
            Text("It's okay!")
                .font(.system(size: 24, weight: .semibold))
            Text("It's perfectly natural to feel scared, and your feelings are valid. It's okay to take your time to overcome this fear.")
            Text("Don't worry, we still have another method that you can try to reduce your fear.")
        }
    }
}

struct AssesmentResultRelaxed: View {
    var body: some View {
        VStack(spacing: 25){
            Text("That's good!")
                .font(.system(size: 24, weight: .semibold))
            VStack(alignment: .leading, spacing: 25) {
                Text("Remember, it's okay to feel scared, but don't forget to celebrate these moments of relief, for they are proof of your resilience and progress.")
                Text("We still have another method that you can try to reduce your fear.")
            }
        }
    }
}

struct AssesmentResult_Previews: PreviewProvider {
    static var previews: some View {
        AssesmentResult()
    }
}
