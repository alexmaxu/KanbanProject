//
//  ContentView.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var reposVM: ReposVM
    
    var body: some View {
        ForEach(reposVM.reposList) { repo in
            Text(repo.name)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ReposVM())
}

