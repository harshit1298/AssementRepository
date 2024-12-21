//
//  BottomSheetDialog.swift
//  DemoApplication_SwiftUI
//
//  Created by Harshit Bansal on 20/12/24.
//

import Foundation
import SwiftUI

struct BottomSheetDialog: View {
    let items: [String]

    var body: some View {
        VStack(spacing: 16) {
            Text("Statistics")
                .font(.headline)

            Text("List has \(items.count) items")
                .font(.subheadline)

            let characterCounts = characterFrequency(items: items)
            ForEach(characterCounts.prefix(3), id: \.key) { key, value in
                HStack {
                    Text("\(key):")
                    Spacer()
                    Text("\(value)")
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
    }

    private func characterFrequency(items: [String]) -> [(key: Character, value: Int)] {
        var frequencies = [Character: Int]()
        for item in items {
            for char in item.lowercased() {
                frequencies[char, default: 0] += 1
            }
        }
        return frequencies.sorted { $0.value > $1.value }
    }
}
