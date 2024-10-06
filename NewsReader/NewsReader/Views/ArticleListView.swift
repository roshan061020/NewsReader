//
//  ArticleListView.swift
//  NewsReader
//
//  Created by Roshan yadav on 06/10/24.
//


import SwiftUI

struct ArticleListView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var viewModel = ArticleListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                CategoryFilterView(data: Category.allCases,
                                   selectedCategory: $viewModel.selectedCategory)
                .onChange(of: viewModel.selectedCategory) { _ in
                        viewModel.articles = []
                        viewModel.fetchArticles()
                }
                
                if viewModel.isLoading {
                    ProgressView("Loading \(viewModel.selectedCategory.capitalized) articles...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.errorMessage != nil {
                    errorWithReTry
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.articles.isEmpty {
                    ContentNotAvailableView(systemImageName:"xmark.circle",
                                            message: "No articles available.")
                } else {
                    ScrollView {
                        LazyVStack(spacing: 10){
                            ForEach(viewModel.articles) { article in
                                NavigationLink {
                                    ArticleDetailView(articleURL: article.url)
                                } label: {
                                    ArticleRowView(article: article)
                                }
                            }
                            if viewModel.isCategoryLoading {
                                ProgressView()
                            }else {
                                Button("Load more") {
                                    viewModel.loadMore()
                                }
                            }
                            
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchArticles()
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    BookmarkNavigationView
                }
            })
            .navigationTitle("Headlines")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var errorWithReTry: some View {
        VStack {
            Button {
                viewModel.articles = []
                viewModel.fetchArticles()
            } label: {
                HStack {
                    Image(systemName: "gobackward")
                    Text("Retry")
                }
            }

            Text(viewModel.errorMessage ?? "")
                .font(.subheadline)
                .foregroundColor(colorScheme == .dark ? .blue : .red)
                .padding()
                .padding(.horizontal)
            
        }
    }
    
    var BookmarkNavigationView: some View {
        NavigationLink {
            BookmarkView()
        } label: {
            HStack{
                Text("BookMarks")
            }
        }
    }
}
