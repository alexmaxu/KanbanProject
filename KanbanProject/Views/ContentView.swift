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
            ZStack {
                TabView (selection: $selectedTab){
                    GeneralReposView(selectedTab: $selectedTab)
                        .tabItem {
                            Image(systemName: "square")
                            Text("Main test2 General")
                            Text("new")
                        }
                        .tag(0)
                    LocalRepositoriesView()
                        .tabItem {
                            Image(systemName: "triangle")
                            
                        }
                        .tag(1)
                }
                .navigationDestination(for: Repository.self) { repo in
                    IssuesView(issueVM: IssuesVM(issueInteractor: IssuesInteractor(), repositoryName: repo.name), title: repo.name)
                }
                .navigationTitle("Repositories")
            }
            .overlay {
                LoadingView().opacity(reposVM.isLoading ? 1 : 0)
            }
            .overlay {
                SomethingWentWrongView().opacity(reposVM.isError ? 1 : 0)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
            .environmentObject(ReposVM(repoInteractor: ReposInteractor()))
    }
}

