//
//  ReposVM.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import Foundation

final class ReposVM: ObservableObject {
    
    let repoInteractor: ReposInteractorProtocol
    
    @Published var generalReposirotyList: [Repository] = []
    
    @Published var localRepositoryList: [Repository] = [] {
        didSet {
            saveLocalRepos()
        }
    }
    
    @Published var isLoading = true
    @Published var isError = false
    
    var page = 1
    var isLastApiPage = false
    
    init(repoInteractor: ReposInteractorProtocol) {
        self.repoInteractor = repoInteractor
        getLocalRepos()
        Task {
            await getGeneralRepos()
            await MainActor.run {
                isLoading = false
            }
        }
    }
    
    func saveLocalRepos() {
        do {
            try repoInteractor.saveLocalRepositories(localRepositories: localRepositoryList)
        } catch {
            isError.toggle()
        }
    }
    
    func getLocalRepos() {
        do {
            self.localRepositoryList = try repoInteractor.loadLocalRepositories()
        } catch {
            isError.toggle()
        }
    }
    
    func deleteReposFromLocalRepository(repoID: Int) {
        if let indexToDelete = localRepositoryList.firstIndex(where: { $0.id == repoID }) {
            do {
                try repoInteractor.deleteIssuesDictionary(
                    repositoryName: localRepositoryList[indexToDelete].name
                )
            } catch {
                isError.toggle()
            }
            localRepositoryList.remove(at: indexToDelete)
        }
    }
    
    func addToLocalRepository(repoID: Int) {
        if let repoToAdd = generalReposirotyList.first(where: { $0.id == repoID }) {
            if !localRepositoryList.contains(repoToAdd) {
                localRepositoryList.append(repoToAdd)
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
                    self.generalReposirotyList += reposResult
                }
            }
        } catch {
            isError.toggle()
        }
    }
    
    func getNextPageRepos(repo: Repository) {
        if repo.id == generalReposirotyList.last?.id && !isLastApiPage {
            page += 1
            Task {
                await getGeneralRepos()
            }
        }
    }
    
}
