//
//  URLRequestBuilder.swift
//  YoutubeReelz
//
//  Created by Usama Fouad on 29/07/2022.
//

import Foundation
import Moya

enum YoutubeService {
    case playlist(parameters: [String : Any])
    case videos(parameters: [String : Any])
}

extension YoutubeService: URLRequestBuilder {
    var path: String {
        switch self {
        case .playlist(_):
            return EndPoints.playlistItems.rawValue
        case .videos(_):
            return EndPoints.videos.rawValue
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .playlist(let parameters), .videos(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}
