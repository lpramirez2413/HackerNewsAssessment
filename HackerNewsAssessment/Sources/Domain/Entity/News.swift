//
//  News.swift
//  HackerNewsAssessment
//
//  Created by Luis Perez on 22/11/24.
//

import Foundation

struct News: Hashable, Codable {
    var id: String
    let title: String?
    let author: String
    let elapsedTime: String
    let url: String?
}
