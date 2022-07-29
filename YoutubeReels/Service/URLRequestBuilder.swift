//
//  URLRequestBuilder.swift
//  YoutubeReelz
//
//  Created by Usama Fouad on 29/07/2022.
//

import Foundation
import Moya

protocol URLRequestBuilder: TargetType {
    var baseURL: URL { get }
    
    var requestURL: URL { get }
    
    var headers: [String: String]? { get }
    
    var method: Moya.Method { get }
    
    var encoding: ParameterEncoding { get }
    
    var urlRequest: URLRequest { get }
}


extension URLRequestBuilder {
    var baseURL: URL {
        return URL(string: K.apiURL)!
    }

    var requestURL: URL {
        return baseURL.appendingPathComponent(path)
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var headers: [String: String]? {
       var header = [String: String]()
       header["Content-Type"] = "application/json"
       header["Accept"] = "application/json"
        
       return header
   }

    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue

        return request
    }
}
