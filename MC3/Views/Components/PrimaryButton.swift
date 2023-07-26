//
//  PrimaryButton.swift
//  MC3
//
//  Created by Wahyu Alfandi on 15/07/23.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
<<<<<<< HEAD
            Text(title)
                .font(.system(size: 15, weight: .semibold))
=======
            Text(title).font(.system(.body, weight: .semibold))
>>>>>>> main
                .foregroundColor(.white)
                .padding(.vertical, 9)
                .frame(maxWidth: .infinity)
                .background(.teal55 as Color)
                .cornerRadius(50)
        }
        .padding(.horizontal, 76)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(title: "Continue") {
            print("working")
        }
    }
}
