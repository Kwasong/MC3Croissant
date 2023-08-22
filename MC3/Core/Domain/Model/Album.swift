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
    let sounds: [Sound]
}


extension Album{
    static var mockAlbums = [
        Album(
            title: "Traditional Jazz",
            artist: "Vendla",
            numOfTrack: 20,
            numOfMinutes: 65,
            imageUrl: "jazz",
            isFavorite: true,
            sounds: Sound.mockSounds
        ),
        Album(
            title: "Nature",
            artist: "NCS",
            numOfTrack: 13,
            numOfMinutes: 41,
            imageUrl: "nature",
            isFavorite: false,
            sounds: Sound.mockSounds2
        ),
        Album(
            title: "Colour Noise",
            artist: "NCS",
            numOfTrack: 5,
            numOfMinutes: 6,
            imageUrl: "colored-noise",
            isFavorite: false,
            sounds: Sound.mockSounds3
        ),
        
    ]
}
