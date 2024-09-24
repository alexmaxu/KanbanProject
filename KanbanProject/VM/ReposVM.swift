//
//  ReposVM.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import Foundation

final class ReposVM: ObservableObject {
    
    let repoInteractor: InteractorProtocol
    
    @Published var reposList: [Repos] = []
    @Published var localReposList: [Repos] = [] {
        didSet {
            saveLocalRepos()
        }
    }
    
    init(repoInteractor: InteractorProtocol = Interactor.shared ) {
        self.repoInteractor = repoInteractor
        getLocalRepos()
        Task {
            await getGeneralRepos()
        }
    }
    
    
    
    func saveLocalRepos() {
        do {
            try repoInteractor.saveLocalRepositories(localRepositories: localReposList)
        } catch {
            print(error)
        }
        
    }
    
    func getLocalRepos() {
        do {
            self.localReposList = try repoInteractor.loadLocalRepositories()
        } catch {
            print(error)
        }
    }
    
    func deleteReposFromLocalRepository(repoID: Int) {
        if let indexToDelete = localReposList.firstIndex(where: { $0.id == repoID }) {
            localReposList.remove(at: indexToDelete)
        }
    }
    
    func addToLocalRepository(repoID: Int) {
        if let repoToAdd = reposList.first(where: { $0.id == repoID }) {
            if !localReposList.contains(repoToAdd) {
                localReposList.append(repoToAdd)
            }
        }
    }
    
    func getGeneralRepos() async  {
        do {
            let reposResult = try await repoInteractor.fetchRepos()
            await MainActor.run {
                self.reposList = reposResult
            }
        } catch {
            print(error)
        }
    }
    
}
