//
//  Networking.swift
//  CustomNetworking
//
//  Created by Aubkhon Abdullaev on 18.01.2024.
//

import Foundation

protocol NetworkingProtocol {
    typealias NetworkingResult = (
        (_ result: Result<NetworkingCommandModels.NetworkingResult, Error>) -> Void
    )
    
    func executeRequest(with request: Request, complition: @escaping NetworkingResult)
}

final class Networking: NetworkingProtocol {
    var baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func executeRequest(with request: Request, complition: @escaping NetworkingResult) {
        guard let urlRequest = convert(request) else {
            NSLog("wrong url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                complition(.failure(error))
            }
            complition(.success(NetworkingCommandModels.NetworkingResult(data: data, response: response)))
        }
        
        task.resume()
    }
    
    private func convert(_ request: Request) -> URLRequest? {
        guard let url = generateDestinationURL(for: request) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = request.endpoint.headers
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        
        return urlRequest
    }
    
    private func generateDestinationURL(for request: Request) -> URL? {
        return URL(string: baseUrl + request.endpoint.compositePath)
    }
}
