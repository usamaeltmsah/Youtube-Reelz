//
//  PlaylistViewModel.swift
//  YoutubeReelz
//
//  Created by Usama Fouad on 29/07/2022.
//

import Foundation
import PromiseKit
import Moya

protocol Playlist {
    func getPlaylist(parameters: [String: Any], completion: @escaping (YoutubePlaylist?) -> ())
}

class PlaylistViewModel: Playlist {    
    private var youtubeServices = MoyaProvider<YoutubeService>()
    
    
    func getPlaylist(parameters: [String : Any], completion: @escaping (YoutubePlaylist?) -> ()) {
        firstly { () -> Promise<Any> in
            return ServicesManager.CallApi(self.youtubeServices, YoutubeService.playlist(parameters: parameters))
        }.done({ response in
            guard let response = response as? Response else {
                completion(nil)
                return
            }
            
            let playlistData: YoutubePlaylist = try MyDecoder.decode(data: response.data)
            
            completion(playlistData)
        })
        .catch() { error in
            print(error)
        }
    }
}
