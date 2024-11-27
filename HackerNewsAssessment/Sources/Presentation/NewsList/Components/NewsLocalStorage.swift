//
//  NewsLocalStorage.swift
//  HackerNewsAssessment
//
//  Created by Luis Perez on 25/11/24.
//

import Foundation

protocol LocalStorageProtocol {
    func getSavedNews() -> [News]
    func backupNews(news: [News])
    func saveStoredDeletedNews(_ news: News)
    func getStoredDeletedNews() -> [News]
}

struct NewsLocalStorage: LocalStorageProtocol {
    
    func backupNews(news: [News]) {
        if let data = try? JSONEncoder().encode(news) {
            UserDefaults.standard.set(data, forKey: AppConstants.persistedNewsKey.rawValue)
        }
    }
    
    func getSavedNews() -> [News] {
        if let data = UserDefaults.standard.data(forKey: AppConstants.persistedNewsKey.rawValue),
           let persistedNews = try? JSONDecoder().decode([News].self, from: data) {
            return persistedNews
        } else {
            return []
        }
    }
    
    func saveStoredDeletedNews(_ news: News) {
        var newsCollection = getStoredDeletedNews()
        newsCollection.append(news)
        if let data = try? JSONEncoder().encode(newsCollection) {
            UserDefaults.standard.set(data, forKey: AppConstants.deletedNewsKey.rawValue)
        }
    }
    
    func getStoredDeletedNews() -> [News] {
        if let data = UserDefaults.standard.data(forKey: AppConstants.deletedNewsKey.rawValue),
           let newsCollection = try? JSONDecoder().decode([News].self, from: data) {
            return newsCollection
        } else {
            return []
        }
    }
    
}
