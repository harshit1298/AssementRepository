//
//  SearchBarView.swift
//  DemoApplication_SwiftUI
//
//  Created by Harshit Bansal on 20/12/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search", text: $searchText)
                .padding(8)
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(16)
        .padding()
    }
}
