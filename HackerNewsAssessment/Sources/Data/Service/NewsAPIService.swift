//
//  NewsAPIService.swift
//  HackerNewsAssessment
//
//  Created by Luis Perez on 22/11/24.
//

import Foundation

protocol NewsAPIServiceProtocol {
    func requestNewsListModel(page: Int) async throws -> NewsListModel
}

struct NewsAPIService: NewsAPIServiceProtocol {
    
    var session = URLSession.shared
    
    func requestNewsListModel(page: Int = 1) async throws -> NewsListModel {
        guard let url = URL(string: API.News.newsList(page: page).urlString) else {
            throw APIError.invalidURL
        }
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidStatusCode(httpResponse.statusCode)
            }
            
            return try JSONDecoder().decode(NewsListModel.self, from: data)
            
        } catch let error as DecodingError {
            throw APIError.failedDecoding(error)
        }
    }
}
