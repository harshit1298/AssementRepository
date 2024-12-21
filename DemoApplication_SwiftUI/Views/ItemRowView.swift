//
//  ItemRowView.swift
//  DemoApplication_SwiftUI
//
//  Created by Harshit Bansal on 20/12/24.
//

import SwiftUI

struct ItemRowView: View {
    let item: Item
    
    var body: some View {
        HStack {
            Image(item.image)
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                Text(item.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .background(Color.green.opacity(0.2))
        .cornerRadius(8)
        .padding(.horizontal)
    }
}
