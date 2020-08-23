//
//  Song.swift
//  iTunesDemo
//
//  Created by Milica Jankovic on 22/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

struct Song: Decodable {
    var artistName: String
    var trackName: String
    var artworkImg: String
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case trackName
        case artworkImg = "artworkUrl100"
    }
}
