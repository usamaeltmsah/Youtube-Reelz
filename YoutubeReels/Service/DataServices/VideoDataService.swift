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
    func getVideo(parameters: [String: Any])
}

extension YoutubeReelsViewController: VideoDataServiceProtocol {
    private var youtubeServices: MoyaProvider<YoutubeService> { MoyaProvider<YoutubeService>() }
    
    func getVideo(parameters: [String : Any]) {
        firstly { () -> Promise<Any> in
            return ServicesManager.CallApi(self.youtubeServices, YoutubeService.videos(parameters: parameters))
        }.done({ response in
            guard let response = response as? Response else {
                return
            }
            
            guard let videoData: YoutubeVideo = try MyDecoder.decode(data: response.data) else { return }
            
            self.playlistVM.addNewVideo(videoData)
            
            DispatchQueue.main.async {
                self.reelzCollectionView.reloadData()
            }
        })
        .catch() { error in
            print(error)
        }
    }
}
