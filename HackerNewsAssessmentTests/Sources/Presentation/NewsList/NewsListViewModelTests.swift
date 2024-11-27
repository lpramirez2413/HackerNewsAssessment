//
//  NewsListViewModelTests.swift
//  HackerNewsAssessment
//
//  Created by Luis Perez on 25/11/24.
//

import XCTest
@testable import HackerNewsAssessment

final class NewsListViewModelTests: XCTestCase {
    
    var sut: NewsListViewModel!
    var apiMock: NewsAPIServiceMock!
    var repository: NewsRepository!
    var localStorageMock: NewsLocalStorageMock!

    override func setUp() {
        apiMock = NewsAPIServiceMock()
        repository = NewsRepository(apiService: apiMock)
        localStorageMock = NewsLocalStorageMock()
        sut = NewsListViewModel(useCase: NewsUseCase(repository: repository), localStorage: localStorageMock)
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_getNews_succeed() async {
        // Given
        apiMock.response = .init(page: 1, hits: NewsListModel.HitModel.singleWithNoDate, hitsPerPage: 20)
        
        let expectedResult: [News] = [
            .init(id: "1",
                  title: "Story Title 1",
                  author: "Author 1",
                  elapsedTime: "Unknown date",
                  url: "Story Url 1")
        ]
        
        // When
        await sut.getNews()
        
        // Then
        XCTAssertEqual(sut.currentNews, expectedResult)
    }
    
    func test_getNews_failed() async {
        // Given
        apiMock.error = APIError.invalidResponse
        localStorageMock.mockBackupNews = [
            .init(id: "1",
                  title: "Story Title 1",
                  author: "Author 1",
                  elapsedTime: "Unknown date",
                  url: "Story Url 1")
        ]
        
        let expectedResult: [News] = [
            .init(id: "1",
                  title: "Story Title 1",
                  author: "Author 1",
                  elapsedTime: "Unknown date",
                  url: "Story Url 1")
        ]
        
        // When
        await sut.getNews()
        
        // Then
        XCTAssertEqual(sut.currentNews, expectedResult)
    }
    
    func test_refresh_Succeed() async {
        // Given
        apiMock.response = .init(page: 1, hits: NewsListModel.HitModel.multipleWithNoDate, hitsPerPage: 20)
        
        // When
        await sut.getNews()
        
        // Then
        XCTAssertEqual(sut.currentNews.count, 3)
        
        // And Given
        apiMock.response = .init(page: 1, hits: NewsListModel.HitModel.single, hitsPerPage: 20)
        
        // And When
        await sut.refresh()
        
        // Then
        XCTAssertEqual(sut.currentNews.count, 1)
    }
    
    func test_delete() async {
        // Given
        apiMock.response = .init(page: 1, hits: NewsListModel.HitModel.multipleWithNoDate, hitsPerPage: 20)
        
        // When
        await sut.getNews()
        
        // Then
        XCTAssertEqual(sut.currentNews.count, 3)
        
        // And Given
        
        
        // And When
        sut.deleteNews(at: IndexSet([0]))
        
        // Then
        XCTAssertEqual(localStorageMock.mockDeletedNews.count, 1)
        XCTAssertEqual(sut.filteredNews.count, 2)
    }

}
