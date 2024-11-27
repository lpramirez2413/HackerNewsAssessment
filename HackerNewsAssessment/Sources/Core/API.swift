//
//  API.swift
//  HackerNewsAssessment
//
//  Created by Luis Perez on 22/11/24.
//

import Foundation

protocol APIProtocol {
    static var domain: String { get }
    static var baseUrl: String { get }
}

struct API: APIProtocol {
    
    internal static let domain: String = "https://hn.algolia.com"
    internal static let baseUrl: String = "/api/v1"
    
    enum News {
        case newsList(page: Int)
        
        var urlString: String {
            switch self {
            case .newsList(let page):
                return domain + baseUrl + "/search_by_date?query=mobile&page=\(page)"
            }
        }
    }
}
