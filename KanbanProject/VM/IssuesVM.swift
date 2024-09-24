//
//  IssuesVM.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import Foundation

final class IssuesVM: ObservableObject {
    
    let issueInteractor: InteractorProtocol
    
    var repositoryName = ""
    
    @Published var issuesList: [Issue] = []
    
    @Published var backlog: [Issue] = []
    @Published var next: [Issue] = []
    @Published var doing: [Issue] = []
    @Published var done: [Issue] = []
    
    @Published var issuesDictionary: [String:[Issue]] = [ "backlog":[],
                                                          "next":[],
                                                          "doing":[],
                                                          "done":[] ] {
        didSet {
            saveIssuesDictionary()
        }
    }
    
    init(issueInteractor: InteractorProtocol = Interactor.shared, repositoryName: String) {
        self.issueInteractor = issueInteractor
        self.repositoryName = repositoryName
        Task {
            await loadIssuesDictionary()
        }
        if issuesDictionary.values.allSatisfy({ $0.isEmpty }) {
            Task {
                await fetchIssuesByRepository()
            }
        }
        
    }
    
    func saveIssuesDictionary() {
        do {
            try issueInteractor.saveIssuesDictionary(issuedDictionary: issuesDictionary, repositoryName: repositoryName)
        } catch {
            print(error)
        }
    }
    
    func loadIssuesDictionary() async {
        do {
            let resultIssuesDictionary = try issueInteractor.loadIssuesDictionary(repositoryName: repositoryName)
            await MainActor.run {
                self.issuesDictionary = resultIssuesDictionary
            }
        } catch {
            print(error)
        }
    }

    func fetchIssuesByRepository() async  {
        do {
            let issueResult = try await issueInteractor.fetchIssues(repositoryName: repositoryName)
            await MainActor.run {
                self.issuesDictionary["backlog"] = issueResult
            }
        } catch {
            print(error)
        }
    }
}
