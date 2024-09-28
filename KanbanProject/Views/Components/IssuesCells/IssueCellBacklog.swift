//
//  IssueCell.swift
//  KanbanProject
//
//  Created by Alex  on 25/9/24.
//

import SwiftUI

struct IssueCellBacklog: View {
    
    @ObservedObject var issueVM: IssuesVM
    
    let issue: Issue
    
    var body: some View {
        HStack {
            VStack (alignment: .leading){
                Text(issue.title)
                    .bold()
                    .font(.title2)
                Text(issueVM.shortDate(date: issue.createdAt))
                Text("Comments: \(issue.comments)")
                Text("Issue: \(issue.number)")
            }
            Spacer()
            HStack {
                Spacer()
                Button {
                    issueVM.moveRightBacklog(issue: issue)
                } label: {
                    Image(systemName: "arrow.right")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.green)
                        .bold()
                        .frame(width: 50)
                        .padding(12)
                        .background {
                            Color.green.opacity(0.2)
                        }
                        .clipShape(.rect(cornerRadius: 12))
                    
                }
                
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    IssueCellBacklog(issueVM: IssuesVM(repositoryName: "kanban"), issue: .issuePreview)
}