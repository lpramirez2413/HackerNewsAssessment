//
//  NewsDetailsView.swift
//  HackerNewsAssessment
//
//  Created by Luis Perez on 22/11/24.
//

import SwiftUI

struct NewsDetailsView: View {
    
    @StateObject var viewModel: NewsDetailsViewModel
    
    init(viewModel: NewsDetailsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        if let url = viewModel.news.url {
            WebContainerView(url: url)
        } else {
            Text("\(viewModel.news.title ?? "No content")")
        }
    }
}

#Preview {
    NewsDetailsView(
        viewModel: .init(
            news: .init(
                id: "1",
                title: "",
                author: "",
                elapsedTime: "",
                url: "")
        )
    )
}
