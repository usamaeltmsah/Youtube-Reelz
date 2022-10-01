//
//  PlayListDataService.swift
//  YoutubeReelz
//
//  Created by Usama Fouad on 03/09/2022.
//

import Foundation
import Moya
import PromiseKit

protocol PlayListDataServiceProtocol {
    func getPlaylist(parameters: [String : Any])
}

extension YoutubeReelsViewController: PlayListDataServiceProtocol {
    private var youtubeServices: MoyaProvider<YoutubeService> { MoyaProvider<YoutubeService>() }
    
    func getPlaylist(parameters: [String : Any]) {
        firstly { () -> Promise<Any> in
            return ServicesManager.CallApi(self.youtubeServices, YoutubeService.playlist(parameters: parameters))
        }.done({ response in
            guard let response = response as? Response else { return }
            
            let playlistData: YoutubePlaylist = try MyDecoder.decode(data: response.data)
            guard let playlistItems = playlistData.items else { return }
            
            DispatchQueue.main.async {
                self.loadDataFromPlaylistItems(playlistItems)
            }
        })
        .catch() { error in
            print(error)
        }
    }
}
