//
//  FloatingActionButtonView.swift
//  DemoApplication_SwiftUI
//
//  Created by Harshit Bansal on 20/12/24.
//

import SwiftUI

struct FloatingActionButtonView: View {
    @Binding var showBottomSheet: Bool
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {
                showBottomSheet.toggle()
            }) {
                Image(systemName: "plus")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
            .padding()
        }
    }
}
