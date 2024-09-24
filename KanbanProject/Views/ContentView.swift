//
//  ContentView.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var reposVM: ReposVM
    //    @EnvironmentObject var issueVM: IssuesVM
    
    var body: some View {
        NavigationStack {
            
            //            ForEach(issueVM.issuesList) { issue in
            //                Text(issue.title)
            //            }
            
            TabView {
                GeneralReposView()
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
            .navigationDestination(for: Repos.self) { repo in
                Text(repo.name)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ReposVM())
    //        .environmentObject(IssuesVM())
}

