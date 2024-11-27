//
//  NewsUseCaseTests.swift
//  HackerNewsAssessment
//
//  Created by Luis Perez on 22/11/24.
//

import XCTest
@testable import HackerNewsAssessment

final class NewsUseCaseTests: XCTestCase {
    
    var sut: NewsUseCase!
    var apiMock: NewsAPIServiceMock!
    var repository: NewsRepository!

    override func setUp() {
        apiMock = NewsAPIServiceMock()
        repository = NewsRepository(apiService: apiMock)
        sut = NewsUseCase(repository: repository)
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_fetchInitialNewsList_succeed() async {
        // Given
        apiMock.response = .init(page: 1, hits: NewsListModel.HitModel.single, hitsPerPage: 20)
        let expectedResult = NewsList(
            pageNumber: 1,
            news: [
                .init(id: "1",
                      title: "Story Title 1",
                      author: "Author 1",
                      elapsedTime: "",
                      url: "Story Url 1")
            ]
        )
        do {
            // When
            let result = try await sut.fetchInitialNewsList()
            
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
    
    func test_fetchNextNewsList_succeed() async {
        // Given
        let pageNumber = 2
        apiMock.response = .init(page: pageNumber, hits: NewsListModel.HitModel.single, hitsPerPage: 20)
        let expectedResult = NewsList(
            pageNumber: pageNumber,
            news: [
                .init(id: "1",
                      title: "Story Title 1",
                      author: "Author 1",
                      elapsedTime: "",
                      url: "Story Url 1")
            ]
        )
        do {
            // When
            let result = try await sut.fetchNextNewsList(page: pageNumber)
            
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

}
