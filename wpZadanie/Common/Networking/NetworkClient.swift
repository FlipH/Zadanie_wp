//
//  NetworkClient.swift
//  wpZadanie
//
//  Created by Filip Harasim on 29/02/2020.
//  Copyright © 2020 Filip Harasim. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case missingData
    case connectionFailure
    case decodingFailure
    case unableToCreateRequest
}


protocol NetworkClientProtocol {
    @discardableResult func downloadData(for endpoint: NetworkClient.Endpoint, completion: @escaping(Result<Data, Error>) -> Void) -> URLSessionDataTask?
}


class NetworkClient: NetworkClientProtocol {
    static let baseUrl = "http://quiz.o2.pl/api/v1/"

    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration)
    }

    func downloadData(for endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask? {
        guard let urlRequest = createRequest(forEndpoint: endpoint) else {
            completion(.failure(NetworkError.unableToCreateRequest))
            return nil
        }
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                let error = NetworkError.missingData
                completion(.failure(error))
                return
            }
            completion(.success(data))
        }
        task.resume()
        return task
    }

    private func createRequest(forEndpoint endpoint: Endpoint) -> URLRequest? {
        guard let url = URL.create(NetworkClient.baseUrl, path: endpoint.path) else {
            return nil
        }
        return URLRequest(url: url)
    }

}

extension URL {
    static func create(_ baseUrl: String, path: String) -> URL? {
        guard var components = URLComponents(string: baseUrl) else { return nil }
        components.path += path
        return components.url
    }
}
