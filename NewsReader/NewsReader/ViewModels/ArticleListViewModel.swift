//
//  ArticleListViewModel.swift
//  NewsReader
//
//  Created by Roshan yadav on 06/10/24.
//

import Foundation

@MainActor
class ArticleListViewModel: ObservableObject {
    @Published var articles: [NewsArticle] = []
    @Published var selectedCategory: String = Category.defaultCategory {
        didSet{
            currentPage = 1
        }
    }
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    @Published var isCategoryLoading: Bool = false
    
    private var articleProvider: any ArticleRepository
    private var newsService: any NewsAPIProtocol
    private var currentPage: Int = 1
    
    init(newsService: any NewsAPIProtocol = NewsService(),
         articleProvider: any ArticleRepository = ArticleRepositoryManager()) {
        self.newsService = newsService
        self.articleProvider = articleProvider
    }

    func fetchArticles() {
        guard articles.isEmpty else {return}
        isLoading = true
        
        Task { [weak self] in
            guard let strongSelf = self else {return}
            do {
                let fetchedArticles = try await strongSelf.newsService.fetchHeadlines(for: strongSelf.selectedCategory, page: strongSelf.currentPage)
                strongSelf.handleSuccess(with: fetchedArticles,
                                         for: strongSelf.selectedCategory)
            } catch {
                strongSelf.handleError(with: error.localizedDescription,
                                       for: strongSelf.selectedCategory)
            }
        }
    }
    
    
    func handleSuccess(with articles: [Article], for category: String) {
        DispatchQueue.main.async { [weak self] in
            let newsArticles = articles.map{NewsArticle(from: $0, forCategory: category)}
            // Save articles to Core Data for offline access
            self?.articleProvider.saveArticles(newsArticles)
            self?.articles = newsArticles
            self?.isLoading = false
            self?.errorMessage = nil
        }
    }
    
    func loadMore() {
        currentPage += 1
        Task { [weak self] in
            guard let strongSelf = self else {return}
            do {
                self?.isCategoryLoading = true
                let fetchedArticles = try await strongSelf.newsService.fetchHeadlines(for: strongSelf.selectedCategory, page: strongSelf.currentPage)
                let newsArticles = fetchedArticles.map{NewsArticle(from: $0, forCategory: strongSelf.selectedCategory)}
                self?.articleProvider.saveArticles(newsArticles)
                self?.articles.append(contentsOf: newsArticles)
                self?.isCategoryLoading = false
                self?.errorMessage = nil
            } catch {
                strongSelf.isCategoryLoading = false
                strongSelf.handleError(with: error.localizedDescription,
                                       for: strongSelf.selectedCategory)
            }
        }
    }
    
    func handleError(with message: String, for category: String) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.isLoading = false
            strongSelf.articles = strongSelf.articleProvider.fetchArticles(for: category)
            if strongSelf.articles.isEmpty {
                strongSelf.errorMessage = message
            } else {
                strongSelf.errorMessage = nil
            }
        }
    }
}
