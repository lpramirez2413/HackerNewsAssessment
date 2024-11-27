//
//  NewsAPIServiceMock.swift
//  HackerNewsAssessment
//
//  Created by Luis Perez on 22/11/24.
//

@testable import HackerNewsAssessment

class NewsAPIServiceMock: NewsAPIServiceProtocol {
    
    var response: NewsListModel?
    var error: Error?
    
    func requestNewsListModel(page: Int) async throws -> NewsListModel {
        if let error = error {
            throw error
        } else if let response = response {
            return response
        }
        throw APIError.unknown
    }
    
}
