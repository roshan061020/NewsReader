//
//  BookmarkView.swift
//  NewsReader
//
//  Created by Roshan yadav on 06/10/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookmarkView: View {
    @StateObject private var viewModel = BookmarkViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.isLoading {
                ProgressView()
            } else if !viewModel.bookmarkedArticles.isEmpty {
                ScrollView(showsIndicators: false){
                    LazyVStack (pinnedViews: .sectionHeaders){
                        Section {
                            ForEach(viewModel.bookmarkedArticles, id: \.url) { article in
                                    NavigationLink(destination: ArticleDetailView(articleURL: article.url)) {
                                        ArticleRowView(article: article)
                                    }
                            }
                        } header: {
                            ZStack{
                                Color.gray
                                Text("Total Bookmarked Articles: \(viewModel.bookmarkedArticles.count)")
                            }
                            
                        }
                    }
                    
                }
            } else {
                Text("No bookmarked articles.".capitalized)
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("Bookmarks")
        .onAppear {
            viewModel.fetchBookmarkedArticles()
        }
    }
}

