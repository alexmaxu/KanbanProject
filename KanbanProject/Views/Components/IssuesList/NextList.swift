//
//  NextList.swift
//  KanbanProject
//
//  Created by Alex  on 26/9/24.
//

import SwiftUI

struct NextList: View {
    
    @ObservedObject var issueVM: IssuesVM
    
    var body: some View {
        List {
            if issueVM.issuesDictionary[.next] == [] {
                Text("There is no issues.")
            } else {
                ForEach(issueVM.issuesDictionary[.next] ?? []) { issue in
                    IssueCellNext(issueVM: issueVM, issue: issue)
                }
            }
        }
    }
}

#Preview {
    NextList(issueVM: IssuesVM(issueInteractor: IssuesInteractor(), repositoryName: "kanban"))
}
