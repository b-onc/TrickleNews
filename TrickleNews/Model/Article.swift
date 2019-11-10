//
//  Article.swift
//  TrickleNews
//
//  Created by Bahadir Oncel on 6.11.2019.
//  Copyright © 2019 Piyuv OU. All rights reserved.
//

import Foundation

struct Article: Hashable, Codable {
    struct Source: Hashable, Codable {
        let id: String?
        let name: String
    }
    
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: URL?
    let urlToImage: URL?
    let publishedAt: Date?
    let content: String?
    
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.url == rhs.url
    }
}
