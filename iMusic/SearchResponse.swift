//
//  TrackModels.swift
//  iMusic
//
//  Created by Akan Akysh on 1/28/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Decodable {
    var trackName: String
    var artistName: String
    var collectionName: String?
    var artworkUrl100: String?
}
