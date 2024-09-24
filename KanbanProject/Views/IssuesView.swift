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
                ForEach(issueVM.issuesDictionary["backlog"] ?? []) { issue in
                    Text(issue.title)
                }
            }
        }
    }
}

#Preview {
    IssuesView(issueVM: IssuesVM(repositoryName: "kanban"))
}
