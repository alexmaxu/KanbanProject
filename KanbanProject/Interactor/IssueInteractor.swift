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
    
    func saveIssuesDictionary(issuedDictionary: [KanbanColumn:[Issue]],
                              repositoryName: String) throws
    func loadIssuesDictionary(repositoryName: String) throws -> [KanbanColumn:[Issue]]
}


struct IssuesInteractor: NetworkInteractor, IssuesInteractorProtocol {
    
    func fetchIssues(repositoryName: String) async throws -> [Issue] {
        try await getJSONFromURL(url: .getIssuesURL(repositoryName: repositoryName),
                                 type: [Issue].self)
    }
    
    func deleteIssuesDictionary(repositoryName: String) throws {
        let urlPath = URL.documentsDirectory.appending(path: "\(repositoryName).json").path()
        if FileManager.default.fileExists(atPath: urlPath) {
            try FileManager.default.removeItem(atPath: urlPath)
        }
    }
    
    func saveIssuesDictionary(issuedDictionary: [KanbanColumn:[Issue]],
                              repositoryName: String) throws {
        let url = URL.documentsDirectory.appending(path: "\(repositoryName).json")
        let data = try JSONEncoder().encode(issuedDictionary)
        try data.write(to: url)
    }
    
    func loadIssuesDictionary(repositoryName: String) throws -> [KanbanColumn:[Issue]] {
        let url = URL.documentsDirectory.appending(path: "\(repositoryName).json")
        let urlPath = url.path()
        
        if FileManager.default.fileExists(atPath: urlPath) {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([KanbanColumn:[Issue]].self, from: data)
        } else {
            return [.backlog:[], .next:[], .doing:[], .done:[]]
        }
    }
}
