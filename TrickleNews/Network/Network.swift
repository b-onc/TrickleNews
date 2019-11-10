//
//  Network.swift
//  TrickleNews
//
//  Created by Bahadir Oncel on 6.11.2019.
//  Copyright © 2019 Piyuv OU. All rights reserved.
//

import Foundation
import Moya

class Network {
    private let moyaProvider = MoyaProvider<API>()
    
    func request<T: Codable>(_ target: API, completion: @escaping ((T) -> Void)) {
        moyaProvider.request(target) { (result) in
            switch result {
            case .success(let response):
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    completion(try response.map(T.self, using: decoder))
                } catch {
                    fatalError("error: \(error), response: \(String(describing: String(data: response.data, encoding: .utf8)))")
                }
            case .failure(let error):
                fatalError("error: \(error)")
            }
        }
    }
}
