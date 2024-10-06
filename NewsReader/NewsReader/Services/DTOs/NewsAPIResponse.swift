//
//  NewsAPIResponse.swift
//  NewsReader
//
//  Created by Roshan yadav on 06/10/24.
//


import Foundation

struct NewsAPIResponse: Decodable {
    let articles: [Article]
}

