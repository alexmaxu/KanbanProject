//
//  Interactor.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import Foundation

protocol ReposInteractorProtocol {
    func fetchRepos(page: Int) async throws -> [Repos]
    
    func loadLocalRepositories() throws -> [Repos]
    func saveLocalRepositories(localRepositories: [Repos]) throws
    
    func deleteIssuesDictionary(repositoryName: String) throws
}

struct ReposInteractor: NetworkInteractor, ReposInteractorProtocol {
    
    static let shared = ReposInteractor()
    
    func fetchRepos(page: Int) async throws -> [Repos] {
        try await getJSONFromURLRequest(request: .get(url: .getReposURL, page: page), type: [Repos].self)
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
    
    func deleteIssuesDictionary(repositoryName: String) throws {
        if FileManager.default.fileExists(atPath: URL.documentsDirectory.appending(path: "\(repositoryName).json").path()) {
            try FileManager.default.removeItem(atPath: URL.documentsDirectory.appending(path: "\(repositoryName).json").path())
        }
    }
}
