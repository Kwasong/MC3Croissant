//
//  NetworkImage.swift
//  MC3
//
//  Created by Wahyu Alfandi on 19/07/23.
//

import SwiftUI

struct NetworkImage: View {
    let imageUrl: String
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    
    init(imageUrl: String, width: CGFloat = 100, height: CGFloat = 100, cornerRadius: CGFloat = 0) {
        self.imageUrl = imageUrl
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
    }
    
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .empty:
                ProgressView() // Placeholder view shown while loading
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(cornerRadius)
            case .failure(let error):
                Text("Failed to load image: \(error.localizedDescription)")
                    .foregroundColor(.red)
            @unknown default:
                Text("Unknown state")
            }
        }.frame(width: width, height: height)
        
    }
}

struct NetworkImage_Previews: PreviewProvider {
    static var previews: some View {
        NetworkImage(imageUrl: "https://images.unsplash.com/photo-1682686581797-21ec383ead02?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80", width: 100, height: 100)
    }
}
