//
//  StatisticsView.swift
//  DemoApplication_SwiftUI
//
//  Created by Harshit Bansal on 20/12/24.
//

import SwiftUI

struct StatisticsView: View {
    let items: [Item]

    var body: some View {
        VStack(spacing: 20) {
            Text("Statistics")
                .font(.headline)

            Text("List \(items.count) items")

            let topOccurrences = calculateTopOccurrences()

            ForEach(topOccurrences, id: \.key) { key, value in
                Text("\(key) = \(value)")
            }
        }
        .padding()
    }

    func calculateTopOccurrences() -> [(key: Character, value: Int)] {
        let allTitles = items.map { $0.title }.joined()
        let occurrences = Dictionary(allTitles.map { ($0, 1) }, uniquingKeysWith: +)
        return occurrences.sorted { $0.value > $1.value }.prefix(3).map { $0 }
    }
}
