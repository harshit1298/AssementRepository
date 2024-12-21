//
//  ListViewModel.swift
//  DemoApplication_SwiftUI
//
//  Created by Harshit Bansal on 20/12/24.
//

import SwiftUI

class ListViewModel: ObservableObject {
    
    @Published var images = ["image1", "image2", "image3"]
    @Published var items = [
        Item(image: "image1", title: "Apple", subtitle: "Fruit"),
        Item(image: "image2", title: "Banana", subtitle: "Fruit"),
        Item(image: "image3", title: "Orange", subtitle: "Fruit"),
        Item(image: "image1", title: "Blueberry", subtitle: "Berry")
    ]
    @Published var filteredItems: [Item] = []
    @Published var currentPage = 0
    @Published var searchText = ""
    @Published var showBottomSheet = false

    init() {
        updateListContent()
    }

    // Update list content based on the current page
    func updateListContent() {
        filteredItems = items.filter { $0.image == images[currentPage] }
    }

    // Filter list based on the current page and search text
    func filterList() {
        let combinedFilter: ([Item]) -> [Item] = { [self] list in
            list.filter { $0.image == self.images[self.currentPage] }
                .filter { searchText.isEmpty || $0.title.localizedCaseInsensitiveContains(searchText) }
        }

        filteredItems = combinedFilter(items)
    }
}
