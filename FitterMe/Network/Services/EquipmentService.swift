//
//  ExerciseService.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 14.01.2023.
//

import Foundation

protocol EquipmentServiceProtocol {
    mutating func fetchAllEquipments(completion: @escaping (Result<[String], NetworkError>) -> Void)
}

struct EquipmentService: EquipmentServiceProtocol {
    private let network = Network()
    
    mutating func fetchAllEquipments(completion: @escaping (Result<[String], NetworkError>) -> Void) {
        network.performRequest(request: EquipmentRequest.fetchAllEquipments, completion: completion)
    }
}

