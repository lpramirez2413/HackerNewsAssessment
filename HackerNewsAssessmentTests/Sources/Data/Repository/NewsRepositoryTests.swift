//
//  NewsRepositoryTests.swift
//  HackerNewsAssessment
//
//  Created by Luis Perez on 22/11/24.
//

import XCTest
@testable import HackerNewsAssessment

final class NewsRepositoryTests: XCTestCase {
    
    var sut: NewsRepository!
    var apiMock: NewsAPIServiceMock!

    override func setUp() {
        apiMock = NewsAPIServiceMock()
        sut = NewsRepository(apiService: apiMock)
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_requestNewsListModel_succeed() async {
        // Given
        apiMock.response = .init(page: 1, hits: NewsListModel.HitModel.single, hitsPerPage: 20)
        
        let expectedResult = NewsList(
            pageNumber: 1,
            news: [
                .init(
                    id: "1",
                    title: "Story Title 1",
                    author: "Author 1",
                    elapsedTime: "",
                    url: "Story Url 1")
            ]
        )
        do {
            // When
            let result = try await sut.requestNewsList()
            
            // Then
            XCTAssertEqual(result.pageNumber, expectedResult.pageNumber)
            XCTAssertEqual(result.news.count, expectedResult.news.count)
            guard let firstNews = result.news.first, let expectedFirstNews = expectedResult.news.first else {
                XCTFail()
                return
            }
            XCTAssertEqual(firstNews.title, expectedFirstNews.title)
            XCTAssertEqual(firstNews.author, expectedFirstNews.author)
            XCTAssertEqual(firstNews.url, expectedFirstNews.url)
        } catch {
            // Then
            XCTFail()
        }
    }
    
    func test_requestNewsListModel_throwError_whenInvalidUrl() async {
        // Given
        apiMock.error = APIError.invalidURL
        
        do {
            // When
            _ = try await sut.requestNewsList()
            
            // Then
            XCTFail()
        } catch let error as APIError {
            // Then
            XCTAssertEqual(error, .invalidURL)
            
        } catch {
            XCTFail()
        }
    }
    
    func test_requestNewsListModel_throwError_whenInvalidResponse() async {
        // Given
        apiMock.error = APIError.invalidResponse
        
        do {
            // When
            _ = try await sut.requestNewsList()
            
            // Then
            XCTFail()
        } catch let error as APIError {
            // Then
            XCTAssertEqual(error, .invalidResponse)
            
        } catch {
            XCTFail()
        }
    }

}
