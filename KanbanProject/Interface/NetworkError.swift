//
//  NetworkError.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case nonHTTPURLResponse
    
    case badStatusCode(Int)
    
    case JSONDecoderError(Error)
    
    var errorDescription: String {
        switch self {
        case .nonHTTPURLResponse:
            "Can not cast to HTTPURLResponse."
        case .badStatusCode(let statusCode):
            "Bad status code: \(statusCode)"
        case .JSONDecoderError(let decodeError):
            "Decoding JSON Error: \(decodeError)"
        }
    }
}
