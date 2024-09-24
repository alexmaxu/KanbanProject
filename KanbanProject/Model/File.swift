//
//  File.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import Foundation

struct Repos: Codable, Identifiable {
    let id: Int
    let name: String
    let owner: Owner
}

struct Owner: Codable {
    let login: String
}
