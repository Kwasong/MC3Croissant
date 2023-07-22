//
//  Sound.swift
//  MC3
//
//  Created by Wahyu Alfandi on 20/07/23.
//

import Foundation

struct Sound: Hashable {
    let id: String = UUID().uuidString
    let albumId: String
    let title: String?
    let author: String?
    let soundPath: String?
}


extension Sound {
    static var mockSounds: [Sound] = [
        Sound(
            albumId: Album.mockAlbums[0].id, title: "Night Wish", author: "vendla", soundPath: ""
        ),
        Sound(
            albumId: Album.mockAlbums[0].id, title: "Night Wish", author: "vendla", soundPath: ""
        ),
        Sound(
            albumId: Album.mockAlbums[0].id, title: "Night Wish", author: "vendla", soundPath: ""
        ),
    ]
}
