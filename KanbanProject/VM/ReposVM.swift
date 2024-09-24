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
    
    init(repoInteractor: InteractorProtocol = Interactor.shared ) {
        self.repoInteractor = repoInteractor
        Task {
            await getRepos()
        }
    }
    
    func getRepos() async  {
        do {
            print("getrepos")
            let reposResult = try await repoInteractor.fetchRepos()
            await MainActor.run {
                self.reposList = reposResult
            }
        } catch {
            print(error)
        }
    }
    
}
