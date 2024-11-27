//
//  NewsListModelStubs.swift
//  HackerNewsAssessment
//
//  Created by Luis Perez on 22/11/24.
//

@testable import HackerNewsAssessment

extension NewsListModel.HitModel {
    static let single: [NewsListModel.HitModel] = [
        .init(objectId: "1",
              author: "Author 1",
              createdAt: "2024-11-22T17:13:08Z",
              storyTitle: "Story Title 1",
              storyUrl: "Story Url 1")
    ]
    
    static let singleWithNoDate: [NewsListModel.HitModel] = [
        .init(objectId: "1",
              author: "Author 1",
              createdAt: "",
              storyTitle: "Story Title 1",
              storyUrl: "Story Url 1")
    ]
    
    static let multipleWithNoDate: [NewsListModel.HitModel] = [
        .init(objectId: "1",
              author: "Author 1",
              createdAt: "",
              storyTitle: "Story Title 1",
              storyUrl: "Story Url 1"),
        .init(objectId: "2",
              author: "Author 2",
              createdAt: "",
              storyTitle: "Story Title 2",
              storyUrl: "Story Url 2"),
        .init(objectId: "3",
              author: "Author 3",
              createdAt: "",
              storyTitle: "Story Title 3",
              storyUrl: "Story Url 3")
    ]
}
