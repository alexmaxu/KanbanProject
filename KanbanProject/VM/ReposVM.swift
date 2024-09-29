//
//  ReposVM.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import Foundation

final class ReposVM: ObservableObject {
    
    let repoInteractor: ReposInteractorProtocol
    
    @Published var reposList: [Repository] = []
    @Published var localReposList: [Repository] = [] {
        didSet {
            saveLocalRepos()
        }
    }
    
    var page = 1
    var isLastApiPage = false
    
    init(repoInteractor: ReposInteractorProtocol) {
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
            do {
                try repoInteractor.deleteIssuesDictionary(
                    repositoryName: localReposList[indexToDelete].name
                )
            } catch {
                print(error)
            }
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
            let reposResult = try await repoInteractor.fetchRepos(page: page)
            if reposResult == [] {
                isLastApiPage = true
            } else {
                await MainActor.run {
                    self.reposList += reposResult
                }
            }
        } catch {
            print(error)
        }
    }
    
    func getNextPageRepos(repo: Repository) {
        if repo.id == reposList.last?.id && !isLastApiPage {
            page += 1
            Task {
                await getGeneralRepos()
            }
        }
    }
    
}
