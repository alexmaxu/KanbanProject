//
//  DoneList.swift
//  KanbanProject
//
//  Created by Alex  on 26/9/24.
//

import SwiftUI

struct DoneList: View {
    @ObservedObject var issueVM: IssuesVM
    
    var body: some View {
        List {
            if issueVM.issuesDictionary[.done] == [] {
                Text("There is no issues.")
            } else {
                ForEach(issueVM.issuesDictionary[.done] ?? []) { issue in
                    IssueCellDone(issueVM: issueVM, issue: issue)
                }
            }
        }
    }
}

#Preview {
    DoneList(issueVM: IssuesVM(issueInteractor: IssuesInteractor(), repositoryName: "kanban"))
}
