//
//  Interactor.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import Foundation

protocol InteractorProtocol {
    func fetchRepos() async throws -> [Repos]
    func fetchIssues(repositoryName: String) async throws -> [Issue]
    
    func loadLocalRepositories() throws -> [Repos]
    func saveLocalRepositories(localRepositories: [Repos]) throws
    
    func saveIssuesDictionary(issuedDictionary: [String:[Issue]], repositoryName: String) throws
    func loadIssuesDictionary(repositoryName: String) throws -> [String:[Issue]]
}

struct Interactor: NetworkInteractor, InteractorProtocol {
    
    static let shared = Interactor()
    
    func fetchRepos() async throws -> [Repos] {
        try await getJSONFromURL(url: .getReposURL, type: [Repos].self)
    }
    
    func fetchIssues(repositoryName: String) async throws -> [Issue] {
        try await getJSONFromURL(url: .getIssuesURL(repositoryName: repositoryName), type: [Issue].self)
    }
    
    func saveLocalRepositories(localRepositories: [Repos]) throws {
        let data = try JSONEncoder().encode(localRepositories)
        try data.write(to: URL.documentsDirectory.appending(path: "LocalRepositories.json"))
    }
    
    func loadLocalRepositories() throws -> [Repos] {
        if FileManager.default.fileExists(atPath: URL.documentsDirectory.appending(path: "LocalRepositories.json").path()) {
            let data = try Data(contentsOf: URL.documentsDirectory.appending(path: "LocalRepositories.json"))
            return try JSONDecoder().decode([Repos].self, from: data)
        } else {
            return []
        }
    }
    
    func saveIssuesDictionary(issuedDictionary: [String:[Issue]], repositoryName: String) throws {
        let data = try JSONEncoder().encode(issuedDictionary)
        try data.write(to: URL.documentsDirectory.appending(path: "\(repositoryName).json"))
    }
    
    func loadIssuesDictionary(repositoryName: String) throws -> [String:[Issue]] {
        if FileManager.default.fileExists(atPath: URL.documentsDirectory.appending(path: "\(repositoryName).json").path()) {
            let data = try Data(contentsOf: URL.documentsDirectory.appending(path: "\(repositoryName).json"))
            return try JSONDecoder().decode([String:[Issue]].self, from: data)
        } else {
            return ["backlog":[],
                    "next":[],
                    "doing":[],
                    "done":[]
                    ]
        }
    }
}
