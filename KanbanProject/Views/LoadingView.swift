//
//  LoadingView.swift
//  KanbanProject
//
//  Created by Alex  on 29/9/24.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        ZStack {
            Color.white
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle())
                .padding(20)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
        }
    }
}

#Preview {
    LoadingView()
}
