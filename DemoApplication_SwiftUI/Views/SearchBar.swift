//
//  SearchBar.swift
//  DemoApplication_SwiftUI
//
//  Created by Harshit Bansal on 20/12/24.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String

    var body: some View {
        TextField("Search...", text: $searchText)
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
            .overlay(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            let minY = proxy.frame(in: .global).minY
                            if minY <= 0 {
                                UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
                            }
                        }
                }
            )
    }
}
