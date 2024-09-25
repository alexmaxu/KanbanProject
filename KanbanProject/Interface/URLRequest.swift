//
//  URLRequest.swift
//  KanbanProject
//
//  Created by Alex  on 25/9/24.
//

import Foundation

extension URLRequest {
    static func get(url: URL, page: Int) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.url?.append(queryItems: [URLQueryItem(name: "per_page", value: "7"), .page(page)])
        return request
    }
}

extension URLQueryItem {
    static func page(_ page: Int) -> URLQueryItem {
        URLQueryItem(name: "page", value: "\(page)")
    }
}
