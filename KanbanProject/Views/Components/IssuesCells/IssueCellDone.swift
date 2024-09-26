//
//  IssueCellDone.swift
//  KanbanProject
//
//  Created by Alex  on 25/9/24.
//

import SwiftUI

struct IssueCellDone: View {
    
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
                    issueVM.moveLeftDone(issue: issue)
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.red)
                        .bold()
                        .frame(width: 50)
                        .padding(12)
                        .background {
                            Color.red.opacity(0.2)
                        }
                        .clipShape(.rect(cornerRadius: 12))
                }
                Spacer()
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    IssueCellDone(issueVM: IssuesVM(repositoryName: "kanban"), issue: .issuePreview)
}
