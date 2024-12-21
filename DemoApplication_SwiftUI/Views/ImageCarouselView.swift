//
//  ImageCarouselView.swift
//  DemoApplication_SwiftUI
//
//  Created by Harshit Bansal on 20/12/24.
//

import SwiftUI

struct ImageCarouselView: View {
    @Binding var currentPage: Int
    let images: [String]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentPage) {
                ForEach(images.indices, id: \.self) { index in
                    Image(images[index])
                        .resizable()
                        .scaledToFill()
                        .tag(index)
                        .cornerRadius(16)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 200)

            // Page Control
            HStack(spacing: 8) {
                ForEach(images.indices, id: \.self) { index in
                    Circle()
                        .fill(currentPage == index ? Color.blue : Color.gray)
                        .frame(width: 8, height: 8)
                }
            }
            .padding(.bottom, 8)
        }
        .padding(.horizontal)
    }
}
