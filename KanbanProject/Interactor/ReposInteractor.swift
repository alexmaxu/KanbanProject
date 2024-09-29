//
//  Interactor.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import Foundation

protocol ReposInteractorProtocol {
    func fetchRepos(page: Int) async throws -> [Repository]
    
    func loadLocalRepositories() throws -> [Repository]
    func saveLocalRepositories(localRepositories: [Repository]) throws
    
    func deleteIssuesDictionary(repositoryName: String) throws
}

struct ReposInteractor: NetworkInteractor, ReposInteractorProtocol {
    
    func fetchRepos(page: Int) async throws -> [Repository] {
        try await getJSONFromURLRequest(request: .get(url: .getRepositoryURL, page: page),
                                        type: [Repository].self)
    }
    
    func saveLocalRepositories(localRepositories: [Repository]) throws {
        let url = URL.documentsDirectory.appending(path: "LocalRepositories.json")
        let data = try JSONEncoder().encode(localRepositories)
        try data.write(to: url)
    }
    
    func loadLocalRepositories() throws -> [Repository] {
        let url = URL.documentsDirectory.appending(path: "LocalRepositories.json")
        let urlPath = url.path()
        if FileManager.default.fileExists(atPath: urlPath) {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Repository].self, from: data)
        } else {
            return []
        }
    }
    
    func deleteIssuesDictionary(repositoryName: String) throws {
        let urlPath = URL.documentsDirectory.appending(path: "\(repositoryName).json").path()
        if FileManager.default.fileExists(atPath: urlPath) {
            try FileManager.default.removeItem(atPath: urlPath)
        }
    }
}
