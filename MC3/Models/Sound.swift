//
//  Sound.swift
//  MC3
//
//  Created by Wahyu Alfandi on 20/07/23.
//

import Foundation

struct Sound: Hashable {
    let id: String = UUID().uuidString
//    let albumId: String
    let title: String?
    let author: String?
    let soundPath: String?
    
}


extension Sound {
    static var mockSounds: [Sound] = [
        Sound(
//            albumId: Album.mockAlbums[0].id,
            title: "Summer Walk", author: "vendla", soundPath: "summer-walk"
        ),
        Sound(
//            albumId: Album.mockAlbums[0].id,
            title: "Relaxing", author: "vendla", soundPath: "just-relax"
        ),
        Sound(
//            albumId: Album.mockAlbums[0].id,
            title: "Just Relax", author: "vendla", soundPath: "relaxing"
        ),
    ]
}
