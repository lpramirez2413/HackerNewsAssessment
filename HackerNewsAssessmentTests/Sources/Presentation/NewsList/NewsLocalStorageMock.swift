//
//  NewsLocalStorageMock.swift
//  HackerNewsAssessment
//
//  Created by Luis Perez on 25/11/24.
//

@testable import HackerNewsAssessment

class NewsLocalStorageMock: LocalStorageProtocol {
    
    var mockBackupNews: [News] = []
    var mockDeletedNews: [News] = []
    
    func backupNews(news: [News]) {
        mockBackupNews = news
    }
    
    func getSavedNews() -> [News] {
        mockBackupNews
    }
    
    func saveStoredDeletedNews(_ news: News) {
        var newsCollection = getStoredDeletedNews()
        newsCollection.append(news)
        mockDeletedNews = newsCollection
    }
    
    func getStoredDeletedNews() -> [News] {
        mockDeletedNews
    }
    
}
