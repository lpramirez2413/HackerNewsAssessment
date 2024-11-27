//
//  NewsRowView.swift
//  HackerNewsAssessment
//
//  Created by Luis Perez on 25/11/24.
//

import SwiftUI

struct NewsRowView: View {
    
    let news: News
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(news.title ?? "[Missing Title]")
                .font(.system(size: 16, weight: .semibold))
            HStack(spacing: 4) {
                Group {
                    Text(news.author)
                    Text("-")
                    Text(news.elapsedTime)
                }
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    NewsRowView(news: .init(id: "1",
                            title: "Title 1",
                            author: "Author 1",
                            elapsedTime: "25 min ago",
                            url: "https://google.com"))
}
