//
//  BacklogList.swift
//  KanbanProject
//
//  Created by Alex  on 26/9/24.
//

import SwiftUI

struct BacklogList: View {
    
    @ObservedObject var issueVM: IssuesVM
    
    var body: some View {
        List {
            if issueVM.issuesDictionary[.backlog] == [] {
                Text("There is no issues.")
            } else {
                ForEach(issueVM.issuesDictionary[.backlog] ?? []) { issue in
                    IssueCellBacklog(issueVM: issueVM, issue: issue)
                }
            }
        }
    }
}

#Preview {
    BacklogList(issueVM: IssuesVM(issueInteractor: IssuesInteractor(), repositoryName: "kanban") )
}
