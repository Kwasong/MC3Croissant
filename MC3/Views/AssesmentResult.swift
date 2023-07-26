//
//  AssesmentResult.swift
//  MC3
//
//  Created by Sha Nia Siahaan on 26/07/23.
//

import SwiftUI

struct AssesmentResult: View {
    
    var body: some View {
        VStack {
            AssesmentResultScared()
            .frame(width: screenWidth*4/5)
            .foregroundColor(.lightTeal90)
            Image("ghone-wink")
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

struct AssesmentResult_Previews: PreviewProvider {
    static var previews: some View {
        AssesmentResult()
    }
}
