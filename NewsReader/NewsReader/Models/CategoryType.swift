//
//  CategoryType.swift
//  NewsReader
//
//  Created by Roshan yadav on 06/10/24.
//


import Foundation

enum Category: String, CaseIterable {
    case general
    case business
    case technology
    case health
    case sports
    case entertainment
    case science
    
    var capitalised: String {
        self.rawValue.capitalized
    }
    
    static var defaultCategory: String {
        Category.general.rawValue
    }
}
