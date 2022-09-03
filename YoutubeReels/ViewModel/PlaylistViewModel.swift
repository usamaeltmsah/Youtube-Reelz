//
//  PlaylistViewModel.swift
//  YoutubeReelz
//
//  Created by Usama Fouad on 29/07/2022.
//

import Foundation
import Moya
import PromiseKit

struct PlaylistViewModel {
    private var videos = [YoutubeVideo]()
}

extension PlaylistViewModel {
    var numberOfSections: Int {
        1
    }
    
    mutating func addNewVideo(_ video: YoutubeVideo) {
        videos.append(video)
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        self.videos.count
    }
    
    func videoAtIndex(_ index: Int) -> VideoViewModel {
        let video = videos[index]
        return VideoViewModel(video)
    }
}
