//
//  BookmarkViewModel.swift
//  NewsReader
//
//  Created by Roshan yadav on 06/10/24.
//


import Foundation

//@MainActor
//class BookmarkViewModel: ObservableObject {
//    @Published var bookmarkedNewsArticles: [NewsArticle] = []
//    @Published var selectedNewsArticle: NewsArticle? = nil
//    
//    private let articleRepository: ArticleRepository
//    
//    init(articleRepository: ArticleRepository = ArticleRepositoryManager()) {
//        self.articleRepository = articleRepository
//    }
//    
//    func loadBookmarks() {
//        bookmarkedNewsArticles = articleRepository.fetchBookmarkedArticles()
//    }
//    
//    func saveBookmark(_ NewsArticle: NewsArticle) {
//        articleRepository.update(NewsArticle)
//        loadBookmarks()
//    }
//    
//    func removeBookmark(_ NewsArticle: NewsArticle) {
//        articleRepository.update(NewsArticle)
//        loadBookmarks()
//    }
//}


class BookmarkViewModel: ObservableObject {
    @Published var bookmarkedArticles: [NewsArticle] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private var articleProvider: any ArticleRepository
    
    init(articleProvider: any ArticleRepository = ArticleRepositoryManager()) {
        self.articleProvider = articleProvider
        fetchBookmarkedArticles()
    }
    
    func fetchBookmarkedArticles() {
        isLoading = true
        bookmarkedArticles = articleProvider.fetchBookmarkedArticles()
        isLoading = false
    }

}
