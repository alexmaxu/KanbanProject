//
//  Url.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import Foundation


let mainURL = URL(string: "https://api.github.com")!

extension URL {
    static func getIssuesURL(repositoryName: String) -> URL {
       mainURL.appending(path: "repos/alexmaxu/\(repositoryName)/issues")
    }
    static let getReposURL = mainURL.appending(path: "users/alexmaxu/repos")
}
