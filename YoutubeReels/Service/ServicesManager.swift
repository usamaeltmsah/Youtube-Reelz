//
//  ServicesManager.swift
//  YoutubeReelz
//
//  Created by Usama Fouad on 29/07/2022.
//

import Moya
import PromiseKit

struct ServicesManager {
    static func CallApi<T: TargetType>(_ provider: MoyaProvider<T>, _ target: T) -> Promise<Any> {
        return Promise<Any> { seal in
            provider.request(target, completion: { (result) in
                switch result {
                case let .success(moyaResponse):
                    // http status code is now 200 from here on
                    if moyaResponse.statusCode == 200 {
                        seal.fulfill(moyaResponse)
                    } else {
                        seal.fulfill(moyaResponse)
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                    seal.reject(error)
                }
            })
        }
    }
}
