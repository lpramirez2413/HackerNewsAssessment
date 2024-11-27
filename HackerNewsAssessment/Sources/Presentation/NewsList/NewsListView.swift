//
//  NewsListView.swift
//  HackerNewsAssessment
//
//  Created by Luis Perez on 22/11/24.
//

import SwiftUI

struct NewsListView: View {
    
    @StateObject var viewModel: NewsListViewModel = NewsListViewModel()
    @State private var viewIsLaunched = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.filteredNews, id: \.self) { news in
                    NavigationLink(value: news) {
                        NewsRowView(news: news)
                    }
                }
                .onDelete { indexSet in
                    viewModel.deleteNews(at: indexSet)
                }
                HStack {
                    Spacer()
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundColor(.gray)
                        .foregroundColor(.red)
                        .onAppear {
                            Task {
                                await viewModel.getNews()
                            }
                        }
                    Spacer()
                }
            }
            .refreshable {
                await viewModel.refresh()
            }
            .navigationDestination(for: News.self) { news in
                NewsDetailsView(viewModel: .init(news: news))
            }
            .navigationTitle("Recent News")
        }
    }
}

#Preview {
    NewsListView()
}
