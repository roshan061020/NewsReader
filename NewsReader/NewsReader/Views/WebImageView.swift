//
//  WebImageView.swift
//  NewsReader
//
//  Created by Roshan yadav on 06/10/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct WebImageView: View {
    let imageUrl: URL?
    var imageWidth = UIScreen.main.bounds.width - 40
    var height: CGFloat = 200
    
    var body: some View {
        WebImage(url: imageUrl, scale: 0)
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(width: imageWidth, height: height, alignment: .center)
            
    }
}
