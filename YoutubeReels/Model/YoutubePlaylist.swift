//
//  YoutubePlaylist.swift
//  YoutubeReelz
//
//  Created by Usama Fouad on 29/07/2022.
//

import Foundation

struct YoutubePlaylist: Codable {
    var items: [PlaylistItem]?
    let pageInfo: PageInfo?
}


struct PlaylistItem: Codable {
//    let id: String?
    let contentDetails: ContentDetails?
}

struct ContentDetails: Codable {
    let videoID: String?

    enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
    }
}

struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int?
}
