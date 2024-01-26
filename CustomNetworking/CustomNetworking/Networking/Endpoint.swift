//
//  Endpoint.swift
//  CustomNetworking
//
//  Created by Aubkhon Abdullaev on 18.01.2024.
//

protocol Endpoint {
    var compositePath: String { get }
    var headers: HeaderModel { get }
}
