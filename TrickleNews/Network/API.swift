//
//  API.swift
//  TrickleNews
//
//  Created by Bahadir Oncel on 6.11.2019.
//  Copyright © 2019 Piyuv OU. All rights reserved.
//

import Foundation
import Moya

enum API: TargetType {
    case topHeadlines(pageSize: Int, page: Int)
    case everything
    case sources
    
    var baseURL: URL {
        return Config.serverUrl
    }
    
    var path: String {
        switch self {
        case .topHeadlines:
            return "/top-headlines"
        case .everything:
            return "/everything"
        case .sources:
            return "/sources"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .topHeadlines, .everything, .sources:
            return .get
        }
    }
    
    var sampleData: Data {
        fatalError("todo")
    }
    
    var task: Task {
        switch self {
        case .topHeadlines(let pageSize, let page):
            return .requestParameters(parameters: ["pageSize" : pageSize, "page": page, "country": "us"], encoding: URLEncoding.queryString)
        case .everything, .sources:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .topHeadlines, .everything, .sources:
            return ["x-api-key": Config.serverAuthToken]
        }
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
