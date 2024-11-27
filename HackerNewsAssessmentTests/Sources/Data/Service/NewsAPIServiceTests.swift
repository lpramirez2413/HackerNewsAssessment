//
//  NewsAPIServiceTests.swift
//  HackerNewsAssessment
//
//  Created by Luis Perez on 22/11/24.
//

import XCTest
@testable import HackerNewsAssessment

final class NewsAPIServiceTests: XCTestCase {
    
    var sut: NewsAPIService!

    override func setUp() {
        sut = NewsAPIService()
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_requestNewsListModel_succeed() {
        // TODO: Mock URSession first
    }

}
