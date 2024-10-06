//
//  ArticleEntity.swift
//  NewsReader
//
//  Created by Roshan yadav on 06/10/24.
//


import Foundation
import CoreData

extension NewsArticleEntity {
    static func getArticleEntity(from article: NewsArticle, context: NSManagedObjectContext) -> NewsArticleEntity {
        let newArticle = NewsArticleEntity(context: context)
        newArticle.id = article.id
        newArticle.title = article.title
        newArticle.subtitle = article.subtitle
        newArticle.imageUrl = article.imageUrl?.absoluteString
        newArticle.content = article.content
        newArticle.url = article.url
        newArticle.publishedAt = article.publishedAt
        newArticle.isBookmarked = article.isBookmarked
        newArticle.publisherName = article.publishedBy
        return newArticle
    }
}
