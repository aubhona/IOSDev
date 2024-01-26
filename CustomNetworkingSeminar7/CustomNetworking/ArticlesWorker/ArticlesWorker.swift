//
//  ArticlesWorker.swift
//  CustomNetworking
//
//  Created by Aubkhon Abdullaev on 18.01.2024.
//

import Foundation

final class ArticlesWorker {
    private enum Constants {
        static let baseUrl: String = "https://news.myseldon.com/"
    }
    
    private let newtworking: NetworkingProtocol
    
    init(newtworking: NetworkingProtocol = Networking(baseUrl: Constants.baseUrl)) {
        self.newtworking = newtworking
    }
    
    func fetchNews(page: Int, completion: ((News?) -> Void)?) {
        let endpoint = ArticlesEndpoint.news(rubricId: 4, pageIndex: page)
        fetch(endpoint: endpoint, completion: completion)
    }
    
    private func fetch<Decoded: Decodable>(endpoint: Endpoint, completion: ((Decoded?) -> Void)?) {
        let request = Request(endpoint: endpoint)
        newtworking.executeRequest(with: request) { rawResult in
            guard 
                case let .success(result) = rawResult,
                let data = result.data,
                let decoded = try? JSONDecoder().decode(Decoded.self, from: data)
            else {
                completion?(nil)
                return
            }
            
            completion?(decoded)
        }
    }
}
