//
//  TopHeadlinesResponse.swift
//  TrickleNews
//
//  Created by Bahadir Oncel on 6.11.2019.
//  Copyright © 2019 Piyuv OU. All rights reserved.
//

import Foundation

struct TopHeadlinesResponse: Codable {
    let totalResults: Int
    let articles: [Article]
}
