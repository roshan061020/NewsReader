//
//  RequestBuilder.swift
//  NewsReader
//
//  Created by Roshan yadav on 06/10/24.
//

import Foundation

// Protocol to define the request builder behaviour
protocol RequestBuilder {
    func build() -> URLRequest?
}

// Generic RequestBuilder implementation
class BaseRequestBuilder: RequestBuilder {
    private var urlComponents: URLComponents
    private var queryItems: [URLQueryItem] = []
    
    init(baseURL: String) {
        self.urlComponents = URLComponents(string: baseURL)!
    }
    
    public func setEndpoint(_ endpoint: String){
        urlComponents.path = endpoint
    }

    public func addParameter(key: String, value: String) {
        let queryItem = URLQueryItem(name: key, value: value)
        queryItems.append(queryItem)
    }
    

    public func build() -> URLRequest? {
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            return nil
        }
        return URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData)
    }
}
