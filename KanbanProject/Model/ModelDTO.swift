//
//  ModelDTO.swift
//  KanbanProject
//
//  Created by Alex  on 29/9/24.
//

import Foundation

struct IssueDTO: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let state: String
    let body: String?
    let comments: Int
    let number: Int
    let createdAt: String
    
    var toIssue: Issue {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let createdAtString = formatter.date(from: createdAt) else {
            return Issue(
                id: id,
                title: title,
                state: state,
                body: body,
                comments: comments,
                number: number,
                createdAt: Date()
            )
        }
        
        return Issue(
            id: id,
            title: title,
            state: state,
            body: body,
            comments: comments,
            number: number,
            createdAt: createdAtString
        )
    }
}
