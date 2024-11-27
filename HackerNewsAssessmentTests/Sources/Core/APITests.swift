//
//  APITests.swift
//  HackerNewsAssessmentTests
//
//  Created by Luis Perez on 22/11/24.
//

import XCTest
@testable import HackerNewsAssessment

final class APITests: XCTestCase {
    
    let baseUrl = API.baseUrl
    let domain = API.domain

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_buildNewsListUrl() {
        let endpoint = API.News.newsList(page: 1)
        XCTAssertEqual(endpoint.urlString, domain+baseUrl+"/search_by_date?query=mobile&page=1")
    }

}
