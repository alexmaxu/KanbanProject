//
//  KanbanProjectTests.swift
//  KanbanProjectTests
//
//  Created by Alex  on 24/9/24.
//


import XCTest
@testable import KanbanProject

final class KanbanProjectUnitTest: XCTestCase {
    
//    var viewModel: IssuesVM!
    
    override func setUpWithError() throws {
//        viewModel = IssuesVM(repositoryName: "kanban")
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMoveRightBacklog() throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        //Given
        let viewModel = IssuesVM(repositoryName: "kanban")
        
        let issue1 = Issue(id: 1231231234, title: "Issue1", state: "open", body: "Issue1 body", comments: 0, number: 1, createdAt: "2024-09-24T09:20:21Z")
        let issue2 = Issue(id: 1231234343, title: "Issue2", state: "open", body: "Issue2 body", comments: 0, number: 2, createdAt: "2024-09-23T09:20:21Z")
        
        //when
        viewModel.issuesDictionary["backlog"] = [issue1, issue2]
        viewModel.moveRightBacklog(issue: issue1)
        
        //Then
        XCTAssertTrue(viewModel.issuesDictionary["next"]?.contains(issue1) == true)
        XCTAssertTrue(viewModel.issuesDictionary["backlog"]?.contains(issue1) == false)
        
        
        XCTAssertTrue(viewModel.issuesDictionary["backlog"]?.contains(issue2) == true)
    }
    
    func testMoveRightNext() throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        //Given
        let viewModel = IssuesVM(repositoryName: "kanban")
        
        let issue1 = Issue(id: 1231231234, title: "Issue1", state: "open", body: "Issue1 body", comments: 0, number: 1, createdAt: "2024-09-24T09:20:21Z")
        let issue2 = Issue(id: 1231234343, title: "Issue2", state: "open", body: "Issue2 body", comments: 0, number: 2, createdAt: "2024-09-23T09:20:21Z")
        
        //when
        viewModel.issuesDictionary["next"] = [issue1, issue2]
        viewModel.moveRightNext(issue: issue1)
        //Then
        XCTAssertTrue(viewModel.issuesDictionary["doing"]?.contains(issue1) == true)
        XCTAssertTrue(viewModel.issuesDictionary["next"]?.contains(issue1) == false)
        
        XCTAssertTrue(viewModel.issuesDictionary["next"]?.contains(issue2) == true)
    }
    
    func testMoveLeftNext() throws {
        //Given
        let viewModel = IssuesVM(repositoryName: "kanban")
        
        let issue1 = Issue(id: 1231231234, title: "Issue1", state: "open", body: "Issue1 body", comments: 0, number: 1, createdAt: "2024-09-24T09:20:21Z")
        let issue2 = Issue(id: 1231234343, title: "Issue2", state: "open", body: "Issue2 body", comments: 0, number: 2, createdAt: "2024-09-23T09:20:21Z")
        
        //when
        viewModel.issuesDictionary["next"] = [issue1, issue2]
        viewModel.moveLeftNext(issue: issue1)
        //Then
        XCTAssertTrue(viewModel.issuesDictionary["backlog"]?.contains(issue1) == true)
        XCTAssertTrue(viewModel.issuesDictionary["next"]?.contains(issue1) == false)
        
        XCTAssertTrue(viewModel.issuesDictionary["next"]?.contains(issue2) == true)
        
    }
    
    func testMoveRightDoing() throws {
        //Given
        let viewModel = IssuesVM(repositoryName: "kanban")
        
        let issue1 = Issue(id: 1231231234, title: "Issue1", state: "open", body: "Issue1 body", comments: 0, number: 1, createdAt: "2024-09-24T09:20:21Z")
        let issue2 = Issue(id: 1231234343, title: "Issue2", state: "open", body: "Issue2 body", comments: 0, number: 2, createdAt: "2024-09-23T09:20:21Z")
        
        //when
        viewModel.issuesDictionary["doing"] = [issue1, issue2]
        viewModel.moveRightDoing(issue: issue1)
        //Then
        XCTAssertTrue(viewModel.issuesDictionary["done"]?.contains(issue1) == true)
        XCTAssertTrue(viewModel.issuesDictionary["doing"]?.contains(issue1) == false)
        
        XCTAssertTrue(viewModel.issuesDictionary["doing"]?.contains(issue2) == true)
        
    }
    
    func testMoveLeftDoing() throws {
        //Given
        let viewModel = IssuesVM(repositoryName: "kanban")
        
        let issue1 = Issue(id: 1231231234, title: "Issue1", state: "open", body: "Issue1 body", comments: 0, number: 1, createdAt: "2024-09-24T09:20:21Z")
        let issue2 = Issue(id: 1231234343, title: "Issue2", state: "open", body: "Issue2 body", comments: 0, number: 2, createdAt: "2024-09-23T09:20:21Z")
        
        //when
        viewModel.issuesDictionary["doing"] = [issue1, issue2]
        viewModel.moveLeftDoing(issue: issue1)
        //Then
        XCTAssertTrue(viewModel.issuesDictionary["next"]?.contains(issue1) == true)
        XCTAssertTrue(viewModel.issuesDictionary["doing"]?.contains(issue1) == false)
        
        XCTAssertTrue(viewModel.issuesDictionary["doing"]?.contains(issue2) == true)
    }
    
    func testMoveLeftDone() throws {
        //Given
        let viewModel = IssuesVM(repositoryName: "kanban")
        
        let issue1 = Issue(id: 1231231234, title: "Issue1", state: "open", body: "Issue1 body", comments: 0, number: 1, createdAt: "2024-09-24T09:20:21Z")
        let issue2 = Issue(id: 1231234343, title: "Issue2", state: "open", body: "Issue2 body", comments: 0, number: 2, createdAt: "2024-09-23T09:20:21Z")
        
        //when
        viewModel.issuesDictionary["done"] = [issue1, issue2]
        viewModel.moveLeftDone(issue: issue1)
        //Then
        XCTAssertTrue(viewModel.issuesDictionary["doing"]?.contains(issue1) == true)
        XCTAssertTrue(viewModel.issuesDictionary["done"]?.contains(issue1) == false)
        
        XCTAssertTrue(viewModel.issuesDictionary["done"]?.contains(issue2) == true)
    }
    
    
}
