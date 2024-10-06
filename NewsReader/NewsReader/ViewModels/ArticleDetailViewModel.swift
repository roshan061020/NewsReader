//
//  ArticleDetailViewModel.swift
//  NewsReader
//
//  Created by Roshan yadav on 06/10/24.
//

import Foundation

@MainActor
class ArticleDetailViewModel: ObservableObject {
    @Published var article: NewsArticle?
    @Published var isLoading = false
    
    private var articleProvider: any ArticleRepository
    
    init(articleProvider: any ArticleRepository = ArticleRepositoryManager()) {
        self.articleProvider = articleProvider
    }
    
    func fetchArticle(for articleUrl: URL) {
        isLoading = true
        let article = articleProvider.fetchArticles(by: articleUrl)
        self.article = article.first
        isLoading = false
    }
    
    func setArticleForPage(article: NewsArticle) {
        self.article = article
    }
    
    func toggleBookmark() {
        guard var article = article else { return }
        article.isBookmarked.toggle()
        articleProvider.update(article)
        fetchArticle(for: article.url)
    }
}
