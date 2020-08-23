//
//  DataAccess.swift
//  iTunesDemo
//
//  Created by Milica Jankovic on 23/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

import Foundation

let dataAccess = DataAccess()

class DataAccess {
    private let restDataClient: RestDataClient = RestDataClient()
    
    func searchSongs(songName: String, successHandler: ((Songs?) -> Void)? = nil, failHandler: ((String?) -> Void)? = nil) {
        restDataClient.searchSongs(for: songName, successHandler: successHandler, failHandler: failHandler)
    }
}

