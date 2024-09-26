//
//  IssueInteractor.swift
//  KanbanProject
//
//  Created by Alex  on 26/9/24.
//

import Foundation

protocol IssuesInteractorProtocol {
    
    func fetchIssues(repositoryName: String) async throws -> [Issue]

    func deleteIssuesDictionary(repositoryName: String) throws
    
    func saveIssuesDictionary(issuedDictionary: [String:[Issue]], repositoryName: String) throws
    func loadIssuesDictionary(repositoryName: String) throws -> [String:[Issue]]
}


struct IssuesInteractor: NetworkInteractor, IssuesInteractorProtocol {
    
    static let shared = IssuesInteractor()
    
    func fetchIssues(repositoryName: String) async throws -> [Issue] {
        try await getJSONFromURL(url: .getIssuesURL(repositoryName: repositoryName), type: [Issue].self)
    }
    
    func deleteIssuesDictionary(repositoryName: String) throws {
        if FileManager.default.fileExists(atPath: URL.documentsDirectory.appending(path: "\(repositoryName).json").path()) {
            try FileManager.default.removeItem(atPath: URL.documentsDirectory.appending(path: "\(repositoryName).json").path())
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
            return ["backlog":[], "next":[], "doing":[], "done":[]]
        }
    }
}