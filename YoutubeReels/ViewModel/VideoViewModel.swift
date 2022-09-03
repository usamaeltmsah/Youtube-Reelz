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
    func getVideo(parameters: [String: Any], completion: @escaping (YoutubeVideo?) -> ())
}

class VideoViewModel: Video {
    private var youtubeServices = MoyaProvider<YoutubeService>()
    
    func getVideo(parameters: [String : Any], completion: @escaping (YoutubeVideo?) -> ()) {
        firstly { () -> Promise<Any> in
            return ServicesManager.CallApi(self.youtubeServices, YoutubeService.videos(parameters: parameters))
        }.done({ response in
            guard let response = response as? Response else {
                completion(nil)
                return
            }
            
            let videoData: YoutubeVideo = try MyDecoder.decode(data: response.data)
            
            completion(videoData)
        })
        .catch() { error in
            print(error)
        }
    }
    
}
