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
    
    @Published var issuesDictionary: [String:[Issue]] = [ "backlog":[], "next":[], "doing":[], "done":[]] {
        didSet {
            saveIssuesDictionary()
        }
    }
    
    init(issueInteractor: InteractorProtocol = KanbanInteractor.shared, repositoryName: String) {
        self.issueInteractor = issueInteractor
        self.repositoryName = repositoryName
        Task {
            await loadIssuesDictionary()
            if issuesDictionary.values.allSatisfy({ $0.isEmpty }) {
                await fetchIssuesByRepository()
            }
        }
    }
    
    func moveRightBacklog(issue: Issue) {
        issuesDictionary["next"]?.append(issue)
        if let issueIndexTodelete = issuesDictionary["backlog"]?.firstIndex(where: { $0.id == issue.id }) {
            issuesDictionary["backlog"]?.remove(at: issueIndexTodelete)
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
    
    func shortDate(date: String) -> String {
        String(date.prefix(10))
    }
}
