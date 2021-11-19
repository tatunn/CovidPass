//
//  Methodable.swift
//  Nikora
//
//  Created by Nikoloz Tatunashvili on 15.04.21.
//

import Foundation

protocol Methodable {
    var request: URLRequest { get }
}

extension Methodable {
    @discardableResult
    func perform<T: Codable>(completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask {
        makeRequest(completion: completion)
    }

    private func makeRequest<T: Codable>(completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let result = try decoder.decode(T.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(error))
                    }
                } else if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(LocalError.network(response: response)))
                }
            }
        }
        task.resume()
        return task
    }
}

enum LocalError: Error {
    case network(response: URLResponse?)
}
