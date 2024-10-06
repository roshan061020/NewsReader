//
//  ArticleRepositoryProtocol.swift
//  NewsReader
//
//  Created by Roshan yadav on 06/10/24.
//

import Foundation
import CoreData

protocol ArticleRepository {
    func saveArticles(_ articles: [NewsArticle])
    func update(_ article: NewsArticle)
    func fetchBookmarkedArticles() -> [NewsArticle]
    func fetchArticles(for category: String) -> [NewsArticle]
    func fetchArticles(by url: URL) -> [NewsArticle]
}

class ArticleRepositoryManager: ArticleRepository {
    private let coreDataManager: PersistentStorageCDManager
    private let context: NSManagedObjectContext
    
    init(coreDataManager: PersistentStorageCDManager = .shared) {
        self.coreDataManager = coreDataManager
        self.context = coreDataManager.getContext()
    }
    
    func saveArticles(_ articles: [NewsArticle]) {
        for article in articles {
            let fetchRequest: NSFetchRequest<NewsArticleEntity> = NewsArticleEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "url == %@", article.url.absoluteString)
            
            do {
                let existingArticles = try context.fetch(fetchRequest)
                // if same article exist then don't add it. 
                if existingArticles.isEmpty {
                    let newArticle = NewsArticleEntity.getArticleEntity(from: article, context: context)
                    newArticle.publisherName = article.publishedBy
                    newArticle.category = article.category
                }
            } catch {
                print("Failed to fetch or create article: \(error.localizedDescription)")
            }
        }
        coreDataManager.saveContext()
    }
    
    func update(_ article: NewsArticle) {
        let predicate = NSPredicate(format: "url == %@", article.url.absoluteString)
        let objects = fetchArticlesObject(for: predicate)
        
        objects.forEach { NewsArticleEntity in
            NewsArticleEntity.isBookmarked = article.isBookmarked
        }
        coreDataManager.saveContext()
    }
    
    func fetchBookmarkedArticles() -> [NewsArticle] {
        let predicate = NSPredicate(format: "isBookmarked == YES")
        return fetchArticles(for: predicate)
    }
    
    func fetchArticles(for category: String) -> [NewsArticle] {
        let predicate = NSPredicate(format: "category.name == %@", category)
        return fetchArticles(for: predicate)
    }
    
    func fetchArticles(by url: URL) -> [NewsArticle] {
        let predicate = NSPredicate(format: "url == %@", url.absoluteString)
        return fetchArticles(for: predicate)
    }
    
    private func fetchArticlesObject(for predicate: NSPredicate) -> [NewsArticleEntity] {
        let fetchRequest: NSFetchRequest<NewsArticleEntity> = NewsArticleEntity.fetchRequest()
        fetchRequest.predicate = predicate
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch articles: \(error.localizedDescription)")
            return []
        }
    }
    
    private func fetchArticles(for predicate: NSPredicate) -> [NewsArticle] {
        let articleEntities = fetchArticlesObject(for: predicate)
        return articleEntities.compactMap { NewsArticle(from: $0) }
    }
}
