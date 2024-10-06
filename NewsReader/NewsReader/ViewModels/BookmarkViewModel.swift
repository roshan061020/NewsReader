//
//  BookmarkViewModel.swift
//  NewsReader
//
//  Created by Roshan yadav on 06/10/24.
//


import Foundation

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
