//
//  URLSession.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//
import Foundation

extension URLSession {
    func getData(url: URL) async throws -> (data: Data, response: HTTPURLResponse) {
        let (data, response) = try await data(from: url)
        
        guard let responseHTTP = response as? HTTPURLResponse else {
            throw NetworkError.nonHTTPURLResponse
        }
        return (data, responseHTTP)
    }
    
    func getDataURLRequest(request: URLRequest) async throws -> (data: Data,
                                                                 response: HTTPURLResponse) {
        let (data, response) = try await data(for: request)
        
        guard let responseHTTP = response as? HTTPURLResponse else {
            throw NetworkError.nonHTTPURLResponse
        }
        return (data, responseHTTP)
    }
        
}
