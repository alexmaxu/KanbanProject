//
//  IssueCell.swift
//  KanbanProject
//
//  Created by Alex  on 25/9/24.
//

import SwiftUI

struct IssueCell: View {
    let issue: Issue
    let issueDate: String
    
    var body: some View {
        HStack {
            VStack (alignment: .leading){
                Text(issue.title)
                    .bold()
                    .font(.title2)
                Text(issueDate)
                Text("Comments: \(issue.comments)")
                Text("Issue: \(issue.number)")
            }
            Spacer()
            HStack {
                Spacer()
                Button {
                    print("left")
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.green)
                        .bold()
                        .frame(width: 50)
                    
                }
                Spacer()
                Button {
                    print("right")
                } label: {
                    Image(systemName: "arrow.right")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.red)
                        .bold()
                        .frame(width: 50)
                    
                }
                
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    IssueCell(issue: .issuePreview, issueDate: "2024-09-24")
}
