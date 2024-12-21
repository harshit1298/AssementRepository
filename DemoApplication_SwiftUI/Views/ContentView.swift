//
//  ContentView.swift
//  DemoApplication_SwiftUI
//
//  Created by Harshit Bansal on 20/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ListViewModel()
    
    var body: some View {
        VStack {
            // Image Carousel
            ImageCarouselView(currentPage: $viewModel.currentPage, images: viewModel.images)
                .onChange(of: viewModel.currentPage) { _ in
                    viewModel.updateListContent()
                }

            // Search Bar
            SearchBarView(searchText: $viewModel.searchText)
                .onChange(of: viewModel.searchText) { _ in
                    viewModel.filterList()
                }

            // List
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.filteredItems, id: \.self) { item in
                        ItemRowView(item: item)
                    }
                }
            }

            // Floating Action Button
            FloatingActionButtonView(showBottomSheet: $viewModel.showBottomSheet)
                .sheet(isPresented: $viewModel.showBottomSheet) {
                    StatisticsView(items: viewModel.items)
                }
        }
    }
}
