//
//  File.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import Foundation

struct Repository: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let owner: Owner
}

struct Owner: Codable, Hashable {
    let login: String
}

struct Issue: Codable, Identifiable, Hashable{
    let id: Int
    let title: String
    let state: String
    let body: String?
    let comments: Int
    let number: Int
    let createdAt: Date
}

enum KanbanColumn: String, Codable {
    case backlog
    case next
    case doing
    case done
}
