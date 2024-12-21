//
//  ListViewModel.swift
//  DemoApplication
//
//  Created by Harshit Bansal on 20/12/24.
//

import Foundation

class ListViewModel {
    
    var allLists: [[ListItem]]
    var carouselImages: [CarouselImage]
    var filteredList: [ListItem]
    var currentPageIndex: Int = 0
    
    init() {
        // Initialize with example data
        self.carouselImages = [
            CarouselImage(name: "image1"),
            CarouselImage(name: "image2"),
            CarouselImage(name: "image3"),
            CarouselImage(name: "image4")
        ]
        
        self.allLists = [
            [ListItem(title: "List item title 1", subtitle: "List item subtitle 1"),
             ListItem(title: "List item title 2", subtitle: "List item subtitle 2"),
             ListItem(title: "List item title 3", subtitle: "List item subtitle 3")],
            [ListItem(title: "List item title 4", subtitle: "List item subtitle 4"),
             ListItem(title: "List item title 5", subtitle: "List item subtitle 5"),
             ListItem(title: "List item title 6", subtitle: "List item subtitle 6")],
            [ListItem(title: "List item title 7", subtitle: "List item subtitle 7"),
             ListItem(title: "List item title 8", subtitle: "List item subtitle 8"),
             ListItem(title: "List item title 9", subtitle: "List item subtitle 9")],
            [ListItem(title: "List item title 10", subtitle: "List item subtitle 10"),
             ListItem(title: "List item title 11", subtitle: "List item subtitle 11"),
             ListItem(title: "List item title 12", subtitle: "List item subtitle 12")]
        ]
        
        self.filteredList = allLists[currentPageIndex]
    }
    
    func getTopOccurrences() -> [(character: Character, count: Int)] {
        let combinedString = filteredList.map { $0.title }.joined().lowercased()
        
        var characterCount: [Character: Int] = [:]
        for char in combinedString where char.isLetter {
            characterCount[char, default: 0] += 1
        }
        
        let sortedOccurrences = characterCount.sorted { $0.value > $1.value }
        return sortedOccurrences.prefix(3).map { (character: $0.key, count: $0.value) }
    }
    
    func updateFilteredList(forPage pageIndex: Int) {
        self.currentPageIndex = pageIndex
        self.filteredList = allLists[pageIndex]
    }
    
    func filterList(withSearchText searchText: String) {
        if searchText.isEmpty {
            self.filteredList = allLists[currentPageIndex]
        } else {
            self.filteredList = allLists[currentPageIndex].filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
}
