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
            List {
                if issueVM.issuesDictionary["backlog"] == [] {
                    Text("There is no issues.")
                } else {
                    ForEach(issueVM.issuesDictionary["backlog"] ?? []) { issue in
                        IssueCellBacklog(issueVM: issueVM, issue: issue)
                    }
                }
            }
            .onAppear {
                
            }
            .tabItem {
                Image(systemName: "triangle")
                Text("Backlog")
            }
            List {
                if issueVM.issuesDictionary["next"] == [] {
                    Text("There is no issues.")
                } else {
                    ForEach(issueVM.issuesDictionary["next"] ?? []) { issue in
                        IssueCellNext(issueVM: issueVM, issue: issue)
                    }
                }
            }
            .tabItem {
                Image(systemName: "square")
                Text("Next")
            }
            List {
                if issueVM.issuesDictionary["doing"] == [] {
                    Text("There is no issues.")
                } else {
                    ForEach(issueVM.issuesDictionary["doing"] ?? []) { issue in
                        IssueCellDoing(issueVM: issueVM, issue: issue)
                    }
                }
            }
            .tabItem {
                Image(systemName: "pentagon")
                Text("Doing")
            }
            List {
                if issueVM.issuesDictionary["done"] == [] {
                    Text("There is no issues.")
                } else {
                    ForEach(issueVM.issuesDictionary["done"] ?? []) { issue in
                        IssueCellDone(issueVM: issueVM, issue: issue)
                    }
                }
            }
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
