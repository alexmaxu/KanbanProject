//
//  Url.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import Foundation

let mainURL = URL(string: "https://api.github.com")!

extension URL {
    static let getRepositoryURL = mainURL.appending(path: "users/alexmaxu/repos")
    
    static func getIssuesURL(repositoryName: String) -> URL {
       mainURL.appending(path: "repos/alexmaxu/\(repositoryName)/issues")
    }
    
}
