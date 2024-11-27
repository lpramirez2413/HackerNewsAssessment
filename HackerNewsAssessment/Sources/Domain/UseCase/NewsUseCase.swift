//
//  NewsUseCase.swift
//  HackerNewsAssessment
//
//  Created by Luis Perez on 22/11/24.
//

import Foundation

struct NewsUseCase {
    private let repository: NewsRepository
    
    init(repository: NewsRepository = NewsRepository()) {
        self.repository = repository
    }
    
    func fetchInitialNewsList() async throws -> NewsList {
        try await fetchNewsList(page: 1)
    }
    
    func fetchNextNewsList(page: Int) async throws -> NewsList {
        try await fetchNewsList(page: page)
    }
    
    private func fetchNewsList(page: Int) async throws -> NewsList {
        try await repository.requestNewsList(page: page)
    }
    
}
