//
//  NewsRepository.swift
//  HackerNewsAssessment
//
//  Created by Luis Perez on 22/11/24.
//

import Foundation

class NewsRepository {
    private let apiService: NewsAPIServiceProtocol
    
    init(apiService: NewsAPIServiceProtocol = NewsAPIService()) {
        self.apiService = apiService
    }
    
    func requestNewsList(page: Int = 1) async throws -> NewsList {
        do {
            let model = try await apiService.requestNewsListModel(page: page)
            return getEntity(from: model)
        } catch {
            throw error
        }
    }
    
    private func getEntity(from model: NewsListModel) -> NewsList {
        let news: [News] = model.hits.map {
            .init(
                id: $0.objectId,
                title: $0.storyTitle,
                author: $0.author,
                elapsedTime: $0.createdAt.timeElapsedFormatted,
                url: $0.storyUrl)
        }
        return NewsList(pageNumber: model.page, news: news)
    }
}
