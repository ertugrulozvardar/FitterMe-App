//
//  URLManager.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 14.01.2023.
//

import Foundation

struct URLManager {
    
    private let scheme = "https"
    private let host = "exercisedb.p.rapidapi.com"
    private var path: String?
    
    mutating func setPath(newPath: String?) -> String {
        if let validatedPath = newPath {
            path = validatedPath
        }
        return path ?? "/exercises"
    }
    
    func getURLScheme() -> String {
        return scheme
    }
    
    func getURLHost() -> String {
        return host
    }
}
