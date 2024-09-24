//
//  NetworkInteractor.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import Foundation

protocol NetworkInteractor {
}

extension NetworkInteractor {
    func getJSONFromURL<T>(url: URL, type: T.Type) async throws -> T where T: Codable {
        let (data, responseHTTP) = try await URLSession.shared.getData(url: url)
        print(data)
        guard responseHTTP.statusCode == 200 else {
            throw NetworkError.badStatusCode(responseHTTP.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(type, from: data)
        } catch {
            throw NetworkError.JSONDecoderError(error)
        }
        
    }
}
