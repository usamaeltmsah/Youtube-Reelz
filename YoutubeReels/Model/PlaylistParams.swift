//
//  PlaylistParams.swift
//  YoutubeReelz
//
//  Created by Usama Fouad on 30/07/2022.
//

import Foundation

struct PlaylistParams {
    var key: String = K.apiKey
    var part: String = "contentDetails"
    var playlistId: String = K.playlistId
    var maxResults: Int = 9
    
    static func getParams(from params: PlaylistParams=PlaylistParams()) -> [String : Any] {
        return [
            "key": params.key,
            "part": params.part,
            "playlistId": params.playlistId,
            "maxResults": params.maxResults
        ]
    }
}
