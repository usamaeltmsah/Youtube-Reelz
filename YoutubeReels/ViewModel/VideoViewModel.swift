//
//  VideoViewModel.swift
//  YoutubeReelz
//
//  Created by Usama Fouad on 29/07/2022.
//

import Foundation
import PromiseKit
import Moya

protocol Video {
    var videoModel: YoutubeVideo? { get set }
    
    func getVideo(parameters: [String: Any], completion: @escaping () -> ())
}

class VideoViewModel: Video {
    var videoModel: YoutubeVideo?
    
    private var youtubeServices = MoyaProvider<YoutubeService>()
    
    func getVideo(parameters: [String : Any], completion: @escaping () -> ()) {
        firstly { () -> Promise<Any> in
            return ServicesManager.CallApi(self.youtubeServices, YoutubeService.videos(parameters: parameters))
        }.done({ [self] response in
            guard let response = response as? Response else {
                return
            }
            
            let videoData: YoutubeVideo = try MyDecoder.decode(data: response.data)
            
            self.videoModel = videoData
            completion()
        })
        .catch() { error in
            print(error)
        }
    }
    
}
