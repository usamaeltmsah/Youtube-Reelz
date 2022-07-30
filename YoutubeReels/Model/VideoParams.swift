//
//  VideoParams.swift
//  YoutubeReelz
//
//  Created by Usama Fouad on 30/07/2022.
//

import Foundation

struct VideoParams {
    var key: String = K.apiKey
    var id : String
    var part: String = "snippet"
    
    static func getParams(from params: VideoParams) -> [String : Any] {
        return [
            "key": params.key,
            "id": params.id,
            "part": params.part
        ]
    }
}
