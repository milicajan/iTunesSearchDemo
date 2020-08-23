//
//  Songs.swift
//  iTunesDemo
//
//  Created by Milica Jankovic on 22/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

struct Songs: Decodable {
    var count: Int
    var all: [Song]
    
    enum CodingKeys: String, CodingKey {
        case count = "resultCount"
        case all = "results"
    }
}
