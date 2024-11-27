//
//  APIError.swift
//  HackerNewsAssessment
//
//  Created by Luis Perez on 22/11/24.
//

import Foundation

enum APIError: Error, Equatable {
    
    case invalidURL
    case invalidResponse
    case invalidStatusCode(Int)
    case failedDecoding(Error)
    case unknown
    
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.invalidResponse, .invalidResponse):
            return true
        case let (.invalidStatusCode(lhsCode), .invalidStatusCode(rhsCode)):
            return lhsCode == rhsCode
        case (.failedDecoding, .failedDecoding):
            return true
        case (.unknown, .unknown):
            return true
        default:
            return false
        }
    }
    
}
