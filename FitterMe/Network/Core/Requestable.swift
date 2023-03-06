//
//  Requestable.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 15.01.2023.
//

import Foundation

protocol Requestable {
    
    var baseURL: String { get }
    var URLpath: String { get }
    func convertToURLRequest() -> URLRequest
}

extension Requestable {
    
    var baseURL: String {
        return "https://exercisedb.p.rapidapi.com"
    }
        
    var httpHeaders: [String: String] {
        let headers = [
            "X-RapidAPI-Key": "ENTER-YOUR-API-KEY-HERE",
            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
        ]
        return headers
    }
    
    func convertToURLRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: URLpath)!)
        request.allHTTPHeaderFields = httpHeaders
        request.httpMethod = getHttpMethod(httpMethod: .get)
        return request
    }
}
