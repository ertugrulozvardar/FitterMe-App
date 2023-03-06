//
//  BodypartService.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 14.01.2023.
//

import Foundation

protocol BodyPartServiceProtocol {
    mutating func fetchAllBodyParts(completion: @escaping (Result<[String], NetworkError>) -> Void)
}

struct BodyPartService: BodyPartServiceProtocol {
    private let network = Network()
    
    mutating func fetchAllBodyParts(completion: @escaping (Result<[String], NetworkError>) -> Void) {
        network.performRequest(request: BodypartRequest.fetchAllBodyParts, completion: completion)
    }
}
