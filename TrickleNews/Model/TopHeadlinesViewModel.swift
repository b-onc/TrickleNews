//
//  HeadlinesManager.swift
//  TrickleNews
//
//  Created by Bahadir Oncel on 6.11.2019.
//  Copyright © 2019 Piyuv OU. All rights reserved.
//

import Foundation

class TopHeadlinesViewModel {
    private let network: Network
    
    private let pagesPerResponse = 21
    
    private var currentPage: Int = 0
    private var totalPages: Int?
    
    init(network: Network) {
        self.network = network
    }
    
    func firstArticleSet(completion: @escaping (([Article]) -> ())) {
        totalPages = nil
        currentPage = 0
        network.request(.topHeadlines(pageSize: pagesPerResponse, page: currentPage)) { [weak self] (topHeadlines: TopHeadlinesResponse) in
            self?.totalPages = topHeadlines.totalResults
            self?.currentPage += 1
            completion(topHeadlines.articles)
        }
    }
    
    func nextArticleSet(completion: @escaping (([Article]) -> ())) {
        if let totalPages = totalPages, (currentPage + 1) * pagesPerResponse > totalPages { return }
        network.request(.topHeadlines(pageSize: pagesPerResponse, page: currentPage)) { [weak self] (topHeadlines: TopHeadlinesResponse) in
            self?.totalPages = topHeadlines.totalResults
            self?.currentPage += 1
            completion(topHeadlines.articles)
        }
    }
}
