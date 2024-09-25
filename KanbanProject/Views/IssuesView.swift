//
//  IssuesView.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import SwiftUI

struct IssuesView: View {
    @ObservedObject var issueVM: IssuesVM
    var body: some View {
        TabView {
            List {
                if issueVM.issuesDictionary.values.allSatisfy( { $0.isEmpty }) {
                    Text("There is no issues.")
                } else {
                    ForEach(issueVM.issuesDictionary["backlog"] ?? []) { issue in
                        IssueCell(issue: issue, issueDate: issueVM.shortDate(date: issue.createdAt))
                    }
                }
            }
            .tabItem {
                Image(systemName: "square")
                Text("Backlog")
            }
            Text("Next")
                .tabItem {
                    Image(systemName: "square")
                    Text("Next")
                }
            Text("Doing")
                .tabItem {
                    Image(systemName: "square")
                    Text("Next")
                }
            Text("Done")
                .tabItem {
                    Image(systemName: "square")
                    Text("Next")
                }
        }
    }
}

#Preview {
    IssuesView(issueVM: IssuesVM(repositoryName: "kanban"))
}
