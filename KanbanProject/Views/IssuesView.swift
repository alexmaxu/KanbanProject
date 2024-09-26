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
        .navigationTitle(title)
    }
}

#Preview {
    NavigationStack {
        IssuesView(issueVM: IssuesVM(repositoryName: "kanban"), title: "title")
    }
}
