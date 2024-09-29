//
//  IssuesView.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import SwiftUI

struct IssuesView: View {
    @ObservedObject var issueVM: IssuesVM
    
    let title: String
    
    var body: some View {
        TabView {
            BacklogList(issueVM: issueVM)
            .tabItem {
                Image(systemName: "triangle")
                Text("Backlog")
            }
            NextList(issueVM: issueVM)
            .tabItem {
                Image(systemName: "square")
                Text("Next")
            }
            DoingList(issueVM: issueVM)
            .tabItem {
                Image(systemName: "pentagon")
                Text("Doing")
            }
            DoneList(issueVM: issueVM)
            .tabItem {
                Image(systemName: "hexagon")
                Text("Done")
            }
        }
        .overlay {
            LoadingView().opacity(issueVM.isLoading ? 1 : 0)
        }
        .overlay {
            SomethingWentWrongView().opacity(issueVM.isError ? 1 : 0)
        }
        .onAppear {
            
            Task {
                await issueVM.obtainIssues()
            }
        }
        .navigationTitle(title)
    }
}

#Preview {
    NavigationStack {
        IssuesView(issueVM: IssuesVM(issueInteractor: IssuesInteractor(), repositoryName: "kanban"), title: "title")
    }
}
