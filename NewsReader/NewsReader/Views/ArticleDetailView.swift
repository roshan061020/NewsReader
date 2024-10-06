//
//  ArticleDetailView.swift
//  NewsReader
//
//  Created by Roshan yadav on 06/10/24.
//


import SwiftUI
import SDWebImageSwiftUI

struct ArticleDetailView: View {
    let articleURL: URL
    @StateObject var articleDetailViewModel = ArticleDetailViewModel()
    
    var body: some View {
        VStack{
            ScrollView {
                WebImageView(imageUrl: articleDetailViewModel.article?.imageUrl)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                VStack(spacing: 10) {
                    Text(articleDetailViewModel.article?.title ?? "").font(.title2).bold()
                    Text(articleDetailViewModel.article?.subtitle ?? "").font(.headline)
                        .lineLimit(nil)
                    Text(articleDetailViewModel.article?.content ?? "").font(.subheadline)
                }
                .padding([.horizontal, .top])
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        articleDetailViewModel.toggleBookmark()
                    }) {
                        articleDetailViewModel.article?.isBookmarked == true
                        ? Image(systemName: "bookmark.fill")
                        : Image(systemName: "bookmark")
                    }.padding()
                }
            })
            .task{
                articleDetailViewModel.fetchArticle(for: articleURL)
            }
            if let url = articleDetailViewModel.article?.url {
                
                NavigationLink{
                    ArticleWebView(articleUrl: url)
                } label: {
                    Text("Read More")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding([.horizontal, .bottom])
                }
            }
        }
    }
}
