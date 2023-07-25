//
//  Sound.swift
//  MC3
//
//  Created by Wahyu Alfandi on 20/07/23.
//

import Foundation

struct Sound: Hashable {
    let id: String = UUID().uuidString
    let title: String?
    let author: String?
    let soundPath: String?
    
}


extension Sound {
    static var mockSounds: [Sound] = [
        Sound(
            title: "Summer Walk", author: "vendla", soundPath: "summer-walk"
        ),
        Sound(
            title: "Relaxing", author: "vendla", soundPath: "just-relax"
        ),
        Sound(
            title: "Just Relax", author: "vendla", soundPath: "relaxing"
        ),
    ]
    
    static var mockSounds2: [Sound] = [
        
        Sound(
            title: "Just Relax", author: "vendla", soundPath: "relaxing"
        ),
        Sound(
            title: "Summer Walk", author: "vendla", soundPath: "summer-walk"
        ),
        Sound(
            title: "Relaxing", author: "vendla", soundPath: "just-relax"
        ),
    ]
    
    static var mockSounds3: [Sound] = [
        Sound(
            title: "Relaxing", author: "vendla", soundPath: "just-relax"
        ),
        Sound(
            title: "Just Relax", author: "vendla", soundPath: "relaxing"
        ),
        
        
        Sound(
            title: "Summer Walk", author: "vendla", soundPath: "summer-walk"
        ),
    ]
}

struct TextToSpeechResponse: Codable {
    let audioURL: URL
}
