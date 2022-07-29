//
//  YoutubeVideo.swift
//  YoutubeReelz
//
//  Created by Usama Fouad on 29/07/2022.
//

import Foundation

struct YoutubeVideo: Codable {
    var items: [VideoItem]?
}

struct VideoItem: Codable {
    let etag, id: String?
    let snippet: Snippet?
}

struct Snippet: Codable {
    let title, snippetDescription: String?
    let thumbnails: Thumbnails?

    enum CodingKeys: String, CodingKey {
        case title
        case snippetDescription = "description"
        case thumbnails
    }
}

struct Thumbnails: Codable {
    let thumbnailsDefault, medium, high: Default?

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high
    }
}

struct Default: Codable {
    let url: String?
    let width, height: Int?
}

