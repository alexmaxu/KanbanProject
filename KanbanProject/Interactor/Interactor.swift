//
//  Interactor.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import Foundation

protocol InteractorProtocol {
    func fetchRepos() async throws -> [Repos]
}

struct Interactor: NetworkInteractor, InteractorProtocol {
    
    static let shared = Interactor()
    
    func fetchRepos() async throws -> [Repos] {
        try await getJSONFromURL(url: .getReposURL, type: [Repos].self)
    }
}
