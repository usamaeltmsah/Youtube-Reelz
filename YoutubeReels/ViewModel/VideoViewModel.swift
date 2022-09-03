//
//  VideoViewModel.swift
//  YoutubeReelz
//
//  Created by Usama Fouad on 29/07/2022.
//

import Foundation

struct VideoViewModel {
    private let video: YoutubeVideo
}

extension VideoViewModel {
    init(_ video: YoutubeVideo) {
        self.video = video
    }
}

extension VideoViewModel {
    var id: String? {
        video.items?.first?.id
    }
    
    var imgUrl: String? {
        video.items?.first?.snippet?.thumbnails?.thumbnailsDefault?.url
    }
}
