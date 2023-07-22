//
//  Album.swift
//  MC3
//
//  Created by Wahyu Alfandi on 19/07/23.
//

import Foundation

struct Album: Hashable {
    let id: String = UUID().uuidString
    let title: String?
    let artist: String?
    let numOfTrack: Int?
    let numOfMinutes: Int?
    let imageUrl: String?
    var isFavorite: Bool
}


extension Album{
    static var mockAlbums = [
        Album(
            title: "Traditional Jazz",
            artist: "Vendla",
            numOfTrack: 20,
            numOfMinutes: 65,
            imageUrl: "https://images.unsplash.com/photo-1415201364774-f6f0bb35f28f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
            isFavorite: true
        ),
        Album(
            title: "Nature",
            artist: "NCS",
            numOfTrack: 13,
            numOfMinutes: 41,
            imageUrl: "https://images.unsplash.com/photo-1426604966848-d7adac402bff?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
            isFavorite: false
        ),
        Album(
            title: "Colour Noise",
            artist: "NCS",
            numOfTrack: 5,
            numOfMinutes: 6,
            imageUrl: "https://images.unsplash.com/photo-1533109721025-d1ae7ee7c1e1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
            isFavorite: false
        ),
        
    ]
}
