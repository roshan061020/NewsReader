//
//  NewsAPIProtocol.swift
//  NewsReader
//
//  Created by Roshan yadav on 06/10/24.
//


import Foundation

protocol NewsAPIProtocol {
    func fetchHeadlines(for category: String,
                        page: Int) async throws -> [Article]
}

class NewsService: NewsAPIProtocol {
    func fetchHeadlines(for category: String,
                        page: Int) async throws -> [Article] {
        
        let builder = NewsArticleRequestBuilder()
            .setEndpoint(.headlines)
            .forCategory(category)
            .forCountry("us")
            .pageSize(8)
            .pageNumber(page)
        
        let response = try await NetworkService().request(with: builder,
                                                          responseType: NewsAPIResponse.self)
        return response.articles.filter{$0.url != URL(string: "https://removed.com")}
    }
}
