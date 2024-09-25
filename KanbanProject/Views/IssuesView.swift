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
                        IssueCellBacklog(issueVM: issueVM, issue: issue)
                    }
                }
            }
            .tabItem {
                Image(systemName: "triangle")
                Text("Backlog")
            }
            List {
                if issueVM.issuesDictionary.values.allSatisfy( { $0.isEmpty }) {
                    Text("There is no issues.")
                } else {
                    ForEach(issueVM.issuesDictionary["next"] ?? []) { issue in
                        IssueCellBacklog(issueVM: issueVM, issue: issue)
                    }
                }
            }
                .tabItem {
                    Image(systemName: "square")
                    Text("Next")
                }
            List {
                if issueVM.issuesDictionary.values.allSatisfy( { $0.isEmpty }) {
                    Text("There is no issues.")
                } else {
                    ForEach(issueVM.issuesDictionary["doing"] ?? []) { issue in
                        IssueCellBacklog(issueVM: issueVM, issue: issue)
                    }
                }
            }
                .tabItem {
                    Image(systemName: "pentagon")
                    Text("Doing")
                }
            List {
                if issueVM.issuesDictionary.values.allSatisfy( { $0.isEmpty }) {
                    Text("There is no issues.")
                } else {
                    ForEach(issueVM.issuesDictionary["done"] ?? []) { issue in
                        IssueCellBacklog(issueVM: issueVM, issue: issue)
                    }
                }
            }
                .tabItem {
                    Image(systemName: "hexagon")
                    Text("Done")
                }
        }
    }
}

#Preview {
    IssuesView(issueVM: IssuesVM(repositoryName: "kanban"))
}
