//
//  ArticlesEndpoint.swift
//  CustomNetworking
//
//  Created by Aubkhon Abdullaev on 18.01.2024.
//

import Foundation

enum ArticlesEndpoint: Endpoint {
    case news(rubricId: Int, pageIndex: Int)
    
    var compositePath: String {
        switch self {
        case .news(let rubricId, let pageIndex):
            "api/Section?rubricId=\(rubricId)&pageSize=8&pageIndex=\(pageIndex)"
        }
    }
    
    var headers: HeaderModel { [:] }
}
