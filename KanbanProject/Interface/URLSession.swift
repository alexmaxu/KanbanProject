//
//  URLSession.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//
import Foundation

extension URLSession {
    func getData(url: URL) async throws -> (data: Data, response: HTTPURLResponse) {
        print("url \(url)")
        let (data, response) = try await data(from: url)
        print(data)
        
        guard let responseHTTP = response as? HTTPURLResponse else {
            throw NetworkError.nonHTTPURLResponse
        }
        return (data, responseHTTP)
    }
}
