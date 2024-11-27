//
//  NewsListModel.swift
//  HackerNewsAssessment
//
//  Created by Luis Perez on 22/11/24.
//

import Foundation

struct NewsListModel: Decodable {
    let page: Int
    let hits: [HitModel]
    let hitsPerPage: Int
    
    struct HitModel: Decodable {
        let objectId: String
        let author: String
        let createdAt: String
        let storyTitle: String?
        let storyUrl: String?
        
        enum CodingKeys: String, CodingKey {
            case objectId = "objectID"
            case author = "author"
            case createdAt = "created_at"
            case storyTitle = "story_title"
            case storyUrl = "story_url"
        }
    }
}

