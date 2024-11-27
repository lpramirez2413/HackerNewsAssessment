//
//  NewsDetailsViewModel.swift
//  HackerNewsAssessment
//
//  Created by Luis Perez on 22/11/24.
//

import Foundation

class NewsDetailsViewModel: ObservableObject {
    @Published var news: News
    
    init(news: News) {
        self.news = news
    }
}
