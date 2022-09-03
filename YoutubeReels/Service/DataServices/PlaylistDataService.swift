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
    func getPlaylist(parameters: [String : Any], completion: @escaping (YoutubePlaylist?) -> ())
}

struct PlaylistDataService {
    private let youtubeServices = MoyaProvider<YoutubeService>()
    
    static let shared = PlaylistDataService()
    
    private init() {}
}

extension PlaylistDataService: PlayListDataServiceProtocol {
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
