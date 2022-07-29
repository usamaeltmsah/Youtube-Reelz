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
    var playlistModel: YoutubePlaylist? { get set }
    
    func getPlaylist(parameters: [String: Any], completion: @escaping () -> ())
}

class PlaylistViewModel: Playlist {
    var playlistModel: YoutubePlaylist?
    
    private var youtubeServices = MoyaProvider<YoutubeService>()
    
    
    func getPlaylist(parameters: [String : Any], completion: @escaping () -> ()) {
        firstly { () -> Promise<Any> in
            return ServicesManager.CallApi(self.youtubeServices, YoutubeService.playlist(parameters: parameters))
        }.done({ [self] response in
            guard let response = response as? Response else {
                return
            }
            
            let playlistData: YoutubePlaylist = try MyDecoder.decode(data: response.data)
            
            self.playlistModel = playlistData
            completion()
        })
        .catch() { error in
            print(error)
        }
    }
}
