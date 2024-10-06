//
//  NetworkService.swift
//  NewsReader
//
//  Created by Roshan yadav on 06/10/24.
//


import Foundation

// Define errors for network requests
enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed
}

// Protocol for making the network service testable
protocol NetworkSession {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSession {}

class NetworkService {
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    // Generic request method
    func request<T: Decodable>(with builder: RequestBuilder, responseType: T.Type) async throws -> T {
        guard let urlRequest = builder.build() else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await session.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                throw NetworkError.invalidResponse
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let decodedResponse = try decoder.decode(T.self, from: data)
                return decodedResponse
            } catch {
                throw NetworkError.decodingFailed
            }
        } catch {
            throw NetworkError.requestFailed(error)
        }
    }
}
