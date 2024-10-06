//
//  ArticleRowView.swift
//  NewsReader
//
//  Created by Roshan yadav on 06/10/24.
//


import SwiftUI
import SDWebImageSwiftUI

struct ArticleRowView: View {
   
    let article: NewsArticle
    
    var body: some View {
        VStack {
            WebImageView(imageUrl: article.imageUrl)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .black.opacity(0.8),radius: 10,y: 10)
            
            VStack(alignment: .leading) {
                Text(article.title)
                    .bold()
                    .font(.headline)
                Text(article.subtitle ?? "")
                    .font(.subheadline)
                    .lineLimit(3)
            }
            .foregroundStyle(.black)
        }
        .padding(10)
        .background(.gray.opacity(0.2))
        .clipShape(.rect(cornerRadius: 20))
        .padding(.horizontal)
    }
}
