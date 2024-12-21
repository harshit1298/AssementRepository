//
//  ItemModel.swift
//  DemoApplication_SwiftUI
//
//  Created by Harshit Bansal on 20/12/24.
//

import Foundation

struct Item: Identifiable, Hashable {
    let id = UUID()
    let image: String
    let title: String
    let subtitle: String
}
