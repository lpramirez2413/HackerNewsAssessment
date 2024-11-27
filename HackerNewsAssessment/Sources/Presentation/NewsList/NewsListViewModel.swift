//
//  NewsListViewModel.swift
//  HackerNewsAssessment
//
//  Created by Luis Perez on 22/11/24.
//

import Foundation





enum AppConstants: String {
    case persistedNewsKey = "PersistedNews"
    case deletedNewsKey = "DeletedNews"
}

class NewsListViewModel: ObservableObject {
    @Published var filteredNews: [News] = []
    @Published var currentPage = 0
    @Published var isLoading = false
    
    private let persistedNewsKey = "PersistedNews"
    private let deletedNewsKey = "DeletedNews"
    var currentNews: [News] = []
    
    let useCase: NewsUseCase
    let localStorage: LocalStorageProtocol
    
    init(useCase: NewsUseCase = NewsUseCase(),
         localStorage: LocalStorageProtocol = NewsLocalStorage()) {
        self.useCase = useCase
        self.localStorage = localStorage
    }
    
    @MainActor
    func getNews() async {
        if !isLoading {
            isLoading = true
            do {
                let newsList = try await useCase.fetchNextNewsList(page: currentPage + 1)
                if !newsList.news.isEmpty {
                    currentPage += 1
                    let upcomingNews = newsList.news
                    currentNews.append(contentsOf: upcomingNews)
                    localStorage.backupNews(news: currentNews)
                    filteredNews = filterDeletedNews(with: currentNews)
                }
                
                isLoading = false
            } catch {
                print("error: \(error)")
                currentNews = localStorage.getSavedNews()
                filteredNews = filterDeletedNews(with: currentNews)
                isLoading = false
            }
        }
    }
    
    @MainActor
    func refresh() async {
        currentPage = 0
        currentNews.removeAll()
        await getNews()
    }
    
    private func filterDeletedNews(with currentNews: [News]) -> [News] {
        var filteredItems: [News] = []
        for currentNewsItem in currentNews {
            let storedDeletedNews = localStorage.getStoredDeletedNews()
            if !storedDeletedNews.contains(where: { $0.id == currentNewsItem.id }) {
                filteredItems.append(currentNewsItem)
            }
        }
        return filteredItems
    }
    
    func deleteNews(at index: IndexSet) {
        guard let firstIndex = index.first else { return }
        let newsCandidate = filteredNews[firstIndex]
        localStorage.saveStoredDeletedNews(newsCandidate)
        filteredNews.remove(at: firstIndex)
    }
    
}
