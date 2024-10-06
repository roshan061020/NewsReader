//
//  NewsArticle.swift
//  NewsReader
//
//  Created by Roshan yadav on 06/10/24.
//


import Foundation
import CoreData

struct NewsArticle: Identifiable, Hashable, Codable {
    let id: String
    let title: String
    let subtitle: String?
    let imageUrl: URL?
    let content: String?
    let url: URL
    let publishedBy: String
    let publishedAt: Date?
    var isBookmarked: Bool
    let category: String
}

extension NewsArticle {
    init?(from newsArticleEntity: NewsArticleEntity) {
        guard let id = newsArticleEntity.id,
              let title = newsArticleEntity.title,
              let url = newsArticleEntity.url,
              let sourceName = newsArticleEntity.publisherName,
              let publishedAt = newsArticleEntity.publishedAt,
              let categoryName = newsArticleEntity.category else {
            print("Skipping article entity due to missing properties")
            return nil
        }
        
        self.id = id
        self.title = title
        self.subtitle = newsArticleEntity.subtitle
        self.imageUrl = newsArticleEntity.imageUrl != nil ? URL(string: newsArticleEntity.imageUrl!) : nil
        self.content = newsArticleEntity.content
        self.url = url
        self.publishedBy = sourceName
        self.publishedAt = publishedAt
        self.isBookmarked = newsArticleEntity.isBookmarked
        self.category = categoryName
    }
    
    init(from article: Article, forCategory category: String) {
        self.id = article.id
        self.title = article.title
        self.subtitle = article.subtitle
        self.imageUrl = article.imageUrl
        self.content = article.content
        self.url = article.url
        self.publishedBy = article.sourceName
        self.publishedAt = article.publishedAt
        self.isBookmarked = false
        self.category = category
    }
}
