//
//  RestDataClient.swift
//  iTunesDemo
//
//  Created by Milica Jankovic on 23/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

import Foundation
import Alamofire

class RestDataClient {
    func searchSongs(for name: String, successHandler: ((Songs?) -> Void)? = nil, failHandler: ((String?) -> Void)? = nil) {
        let url = "https://itunes.apple.com/search?term=\(name)&entity=song"
        
        AF.request(url)
            .validate()
            .responseDecodable(of: Songs.self) { response in
                
                switch response.result {
                case .success:
                    successHandler?(response.value)
                case let .failure(error):
                    failHandler?(error.errorDescription)
                }
        }
    }
}

