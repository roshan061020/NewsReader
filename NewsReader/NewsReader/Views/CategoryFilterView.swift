//
//  CategoryFilterView.swift
//  NewsReader
//
//  Created by Roshan yadav on 06/10/24.
//


import SwiftUI

struct CategoryFilterView: View {
    var data: [Category]
    @Binding var selectedCategory: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(data, id: \.self) { category in
                    Text(category.capitalised)
                        .fontWeight(selectedCategory == category.rawValue ? .bold : .regular)
                        .padding(10)
                        .padding(.horizontal, 10)
                        .background(selectedCategory == category.rawValue ? Color.blue : Color.clear)
                        .cornerRadius(10)
                        .overlay{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 2)
                        }
                        .onTapGesture {
                            withAnimation(.bouncy.delay(0.1)) {
                                selectedCategory = category.rawValue
                            }
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}
