//
//  Article.swift
//  NewsReader
//
//  Created by Roshan yadav on 06/10/24.
//

import Foundation

struct Article: Identifiable, Decodable {
    var id = UUID().uuidString
    let title: String
    let subtitle: String?
    let imageUrl: URL?
    let content: String?
    let url: URL
    let sourceName: String
    let publishedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case title
        case subtitle = "description"
        case imageUrl = "urlToImage"
        case content
        case url
        case source
        case publishedAt
    }
}

struct Source: Codable {
    let name: String
}

extension Article {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle)
        self.imageUrl = try container.decodeIfPresent(URL.self, forKey: .imageUrl)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        self.url = try container.decode(URL.self, forKey: .url)
        let source = try container.decode(Source.self, forKey: .source)
        self.publishedAt = try container.decode(Date.self, forKey: .publishedAt)
        sourceName = source.name
    }
}
