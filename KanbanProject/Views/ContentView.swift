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
        NavigationStack {
            TabView {
                GeneralReposView()
                    .tabItem {
                        Image(systemName: "square")
                        Text("General")
                    }
                LocalRepositoriesView()
                    .tabItem {
                        Image(systemName: "triangle")
                        Text("Local")
                    }
            }
            .navigationDestination(for: Repos.self) { repo in
                IssuesView(issueVM: IssuesVM(repositoryName: repo.name))
            }
            .navigationTitle("Repositories")
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
            .environmentObject(ReposVM())
    }
}

