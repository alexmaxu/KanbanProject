//
//  IssuesVM.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import Foundation

final class IssuesVM: ObservableObject {
    
    let issueInteractor: IssuesInteractorProtocol
    
    var repositoryName: String = ""
    
    @Published var isLoading = true
    @Published var isError = false
    
    @Published var issuesList: [Issue] = []
    
    @Published var issuesDictionary: [KanbanColumn:[Issue]] = [.backlog:[],
                                                               .next:[],
                                                               .doing:[],
                                                               .done:[]] {
        didSet {
            saveIssuesDictionary()
        }
    }
    
    init(issueInteractor: IssuesInteractorProtocol , repositoryName: String) {
        self.issueInteractor = issueInteractor
        self.repositoryName = repositoryName
    }
    
    func obtainIssues() async {
        Task {
            await loadIssuesDictionary()
            if issuesDictionary.values.allSatisfy({ $0.isEmpty }) {
                await fetchIssuesByRepositoryToDictionary()
            } else {
                await fetchIssuesByRepositoryToList()
                await addMissingIssuesToBacklog()
            }
            await MainActor.run {
                isLoading = false
            }
        }
    }
    
    func addMissingIssuesToBacklog() async {
        let issuesFromDictionary = issuesDictionary.values.flatMap({ $0 })
        let uniqueIssuesDictionary = Set(issuesFromDictionary)
        
        let uniqueIssuesArray = Set(issuesList)
        
        if !(uniqueIssuesArray == uniqueIssuesDictionary) {
            let missIssues = Array(uniqueIssuesDictionary.symmetricDifference(uniqueIssuesArray))
            await MainActor.run {
                issuesDictionary[.backlog]? += missIssues
            }
        }
    }
    
    func moveRightBacklog(issue: Issue) {
        issuesDictionary[.next]?.append(issue)
        if let issueIndexTodelete = issuesDictionary[.backlog]?.firstIndex(
            where: { $0.id == issue.id }
        ) {
            issuesDictionary[.backlog]?.remove(at: issueIndexTodelete)
        }
    }
    
    func moveRightNext(issue: Issue) {
        issuesDictionary[.doing]?.append(issue)
        if let issueIndexTodelete = issuesDictionary[.next]?.firstIndex(
            where: { $0.id == issue.id }
        ) {
            issuesDictionary[.next]?.remove(at: issueIndexTodelete)
        }
    }
    
    func moveLeftNext(issue: Issue) {
        issuesDictionary[.backlog]?.append(issue)
        if let issueIndexTodelete = issuesDictionary[.next]?.firstIndex(
            where: { $0.id == issue.id }
        ) {
            issuesDictionary[.next]?.remove(at: issueIndexTodelete)
        }
    }
    
    func moveRightDoing(issue: Issue) {
        issuesDictionary[.done]?.append(issue)
        if let issueIndexTodelete = issuesDictionary[.doing]?.firstIndex(
            where: { $0.id == issue.id }
        ) {
            issuesDictionary[.doing]?.remove(at: issueIndexTodelete)
        }
    }
    
    func moveLeftDoing(issue: Issue) {
        issuesDictionary[.next]?.append(issue)
        if let issueIndexTodelete = issuesDictionary[.doing]?.firstIndex(
            where: { $0.id == issue.id }
        ) {
            issuesDictionary[.doing]?.remove(at: issueIndexTodelete)
        }
    }
    
    func moveLeftDone(issue: Issue) {
        issuesDictionary[.doing]?.append(issue)
        if let issueIndexTodelete = issuesDictionary[.done]?.firstIndex(
            where: { $0.id == issue.id }
         ) {
            issuesDictionary[.done]?.remove(at: issueIndexTodelete)
        }
    }
    
    func saveIssuesDictionary() {
        do {
            try issueInteractor.saveIssuesDictionary(issuedDictionary: issuesDictionary,
                                                     repositoryName: repositoryName)
        } catch {
            isError.toggle()
        }
    }
    
    func loadIssuesDictionary() async {
        do {
            let resultIssuesDictionary = try issueInteractor.loadIssuesDictionary(
                repositoryName: repositoryName
            )
            await MainActor.run {
                self.issuesDictionary = resultIssuesDictionary
            }
        } catch {
            isError.toggle()
        }
    }
    
    func fetchIssuesByRepositoryToDictionary() async  {
        do {
            let issueResult = try await issueInteractor.fetchIssues(repositoryName: repositoryName) 
            await MainActor.run {
                self.issuesDictionary[.backlog] = issueResult
            }
        } catch {
            isError.toggle()
        }
    }
    
    func fetchIssuesByRepositoryToList() async  {
        do {
            let issueResult = try await issueInteractor.fetchIssues(repositoryName: repositoryName)
            await MainActor.run {
                self.issuesList = issueResult
            }
        } catch {
            isError.toggle()
        }
    }

    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter.string(from: date)
    }
}
