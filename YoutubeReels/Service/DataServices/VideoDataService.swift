//
//  VideoDataService.swift
//  YoutubeReelz
//
//  Created by Usama Fouad on 03/09/2022.
//

import Foundation
import Moya
import PromiseKit

protocol VideoDataServiceProtocol {
    func getVideo(parameters: [String: Any], completion: @escaping (YoutubeVideo?) -> ())
}

struct VideoDataService {
    private let youtubeServices = MoyaProvider<YoutubeService>()
    
    static let shared = VideoDataService()
    
    private init() {}
}

extension VideoDataService: VideoDataServiceProtocol {
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
