//
//  ContentView.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var reposVM: ReposVM
    
    @State var selectedTab = 0
    
    var body: some View {
        NavigationStack {
            TabView (selection: $selectedTab){
                GeneralReposView()
                    .onTapGesture {
                        selectedTab = 1
                    }
                    .tabItem {
                        Image(systemName: "square")
                        Text("General")
                    }
                    .tag(0)
                LocalRepositoriesView()
                    .tabItem {
                        Image(systemName: "triangle")
                        Text("Local")
                    }
                    .tag(1)
            }
            .navigationDestination(for: Repository.self) { repo in
                IssuesView(issueVM: IssuesVM(repositoryName: repo.name), title: repo.name)
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

