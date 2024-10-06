//
//  NewsArticleRequestBuilder.swift
//  NewsReader
//
//  Created by Roshan yadav on 06/10/24.
//


import Foundation

enum EndPoint: String {
    case headlines = "top-headlines"
    case source = "top-headlines/sources"
    case everything = "everything"
}

class NewsArticleRequestBuilder: BaseRequestBuilder {
    init(){
        super.init(baseURL: "https://newsapi.org")
    }
    
    func setEndpoint(_ endpoint: EndPoint = .headlines) -> NewsArticleRequestBuilder {
        super.setEndpoint("/v2/\(endpoint.rawValue)")
        return self
    }
    
    func pageSize(_ resultSize: Int) -> NewsArticleRequestBuilder {
        super.addParameter(key: "pageSize", value: "\(resultSize)")
        return self
    }
    
    func pageNumber(_ number: Int) -> NewsArticleRequestBuilder {
        super.addParameter(key: "page", value: "\(number)")
        return self
    }
    
    private func addAuthorizationHeader()  {
        let dataFetcher = plistDataFetcher()
        super.addParameter(key: "apiKey", value: dataFetcher.getValueFromConfig(for: "apiKey") ?? "")
    }
    
    func forCountry(_ code: String = "us") -> NewsArticleRequestBuilder {
        super.addParameter(key: "country", value: code)
        return self
    }
    
    func forCategory(_ name: String) -> NewsArticleRequestBuilder {
        super.addParameter(key: "category", value: name)
        return self
    }
    
    override func build() -> URLRequest? {
        addAuthorizationHeader()
        return super.build()
        
    }
}
