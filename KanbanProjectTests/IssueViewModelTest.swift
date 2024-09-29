//
//  KanbanProjectTests.swift
//  KanbanProjectTests
//
//  Created by Alex  on 24/9/24.
//


import XCTest
@testable import KanbanProject

final class IssueViewModelTest: XCTestCase {
    
    override func setUp() {
    }
    
    override func tearDown() {
    }
    
    func testMoveRightBacklog() throws {
        // Given
        let sut = IssuesVM(
            issueInteractor: IssuesInteractorMock(),
            repositoryName: "Any name"
        )
        sut.issuesDictionary = [.backlog: [issueB, issueA], .next: [], .doing: [], .done: []]
        // When
        sut.moveRightBacklog(issue: issueA)
        // Then
        let expectedDictionary: [KanbanColumn:[Issue]] = [.backlog: [issueB],
                                                          .next: [issueA],
                                                          .doing: [],
                                                          .done: []
        ]
        XCTAssertEqual(sut.issuesDictionary, expectedDictionary)
    }
    
    func testMoveRightNext() throws {
        //Given
        let sut = IssuesVM(
            issueInteractor: IssuesInteractorMock(),
            repositoryName: "Any name"
        )
        sut.issuesDictionary = [.backlog: [], .next: [issueB, issueA], .doing: [], .done: []]
        // When
        sut.moveRightNext(issue: issueA)
        // Then
        let expectedDictionary: [KanbanColumn:[Issue]] = [.backlog: [],
                                                          .next: [issueB],
                                                          .doing: [issueA],
                                                          .done: []
        ]
        XCTAssertEqual(sut.issuesDictionary, expectedDictionary)
    }
    
    func testMoveLeftNext() throws {
        //Given
        let sut = IssuesVM(
            issueInteractor: IssuesInteractorMock(),
            repositoryName: "Any name"
        )
        sut.issuesDictionary = [.backlog: [], .next: [issueB, issueA], .doing: [], .done:[]]
        //when
        sut.moveLeftNext(issue: issueA)
        //Then
        let expectedDictionary: [KanbanColumn:[Issue]] = [.backlog: [issueA],
                                                          .next: [issueB],
                                                          .doing: [],
                                                          .done: []
        ]
        XCTAssertEqual(sut.issuesDictionary, expectedDictionary)
    }
    
    func testMoveRightDoing() throws {
        //Given
        let sut = IssuesVM(
            issueInteractor: IssuesInteractorMock(),
            repositoryName: "Any name"
        )
        sut.issuesDictionary = [.backlog: [], .next: [], .doing: [issueB, issueA], .done:[]]
        //when
        sut.moveRightDoing(issue: issueA)
        //Then
        let expectedDictionary: [KanbanColumn:[Issue]] = [.backlog: [],
                                                          .next: [],
                                                          .doing: [issueB],
                                                          .done: [issueA]
        ]
        XCTAssertEqual(sut.issuesDictionary, expectedDictionary)
    }
    
    func testMoveLeftDoing() throws {
        //Given
        let sut = IssuesVM(
            issueInteractor: IssuesInteractorMock(),
            repositoryName: "Any name"
        )
        sut.issuesDictionary = [.backlog: [], .next: [], .doing: [issueB, issueA], .done:[]]
        //when
        sut.moveLeftDoing(issue: issueA)
        //Then
        let expectedDictionary: [KanbanColumn:[Issue]] = [.backlog: [],
                                                          .next: [issueA],
                                                          .doing: [issueB],
                                                          .done: []
        ]
        XCTAssertEqual(sut.issuesDictionary, expectedDictionary)
    }
    
    func testMoveLeftDone() throws {
        //Given
        let sut = IssuesVM(
            issueInteractor: IssuesInteractorMock(),
            repositoryName: "Any name"
        )
        sut.issuesDictionary = [.backlog: [], .next: [], .doing: [], .done:[issueB, issueA]]
        //when
        sut.moveLeftDone(issue: issueA)
        //Then
        let expectedDictionary: [KanbanColumn:[Issue]] = [.backlog: [],
                                                          .next: [],
                                                          .doing: [issueA],
                                                          .done: [issueB]
        ]
        XCTAssertEqual(sut.issuesDictionary, expectedDictionary)
    }
    
    private var issueA: Issue {
        IssueDTO(id: 0,
              title: "A",
              state: "",
              body: "",
              comments: 9,
              number: 0,
                 createdAt: "2024-09-26T07:44:34Z").toIssue
    }
    
    private var issueB: Issue {
        IssueDTO(id: 1,
              title: "B",
              state: "",
              body: "",
              comments: 9,
              number: 0,
                 createdAt: "2024-09-26T07:44:34Z").toIssue
    }

}

final class IssuesInteractorMock: IssuesInteractorProtocol {
    
    
    func fetchIssues(repositoryName: String) async throws -> [Issue] {
        []
    }
    
    func loadIssuesDictionary(
        repositoryName: String
    ) throws -> [KanbanColumn : [Issue]] {
        [:]
    }
    
    func deleteIssuesDictionary(repositoryName: String) throws { }
    
    func saveIssuesDictionary(
        issuedDictionary: [KanbanColumn : [Issue]],
        repositoryName: String
    ) throws {}
    
}
