//
//  DoingList.swift
//  KanbanProject
//
//  Created by Alex  on 26/9/24.
//

import SwiftUI

struct DoingList: View {
    @ObservedObject var issueVM: IssuesVM
    var body: some View {
        List {
            if issueVM.issuesDictionary["doing"] == [] {
                Text("There is no issues.")
            } else {
                ForEach(issueVM.issuesDictionary["doing"] ?? []) { issue in
                    IssueCellDoing(issueVM: issueVM, issue: issue)
                }
            }
        }
    }
}

#Preview {
    DoingList(issueVM: IssuesVM(repositoryName: "kanban"))
}
