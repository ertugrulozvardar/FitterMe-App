//
//  ExerciseService.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 14.01.2023.
//

import Foundation

protocol ExerciseServiceProtocol {
    mutating func fetchAllExercises(completion: @escaping (Result<[Exercise], NetworkError>) -> Void)
    mutating func fetchExerciseByBodyPart(bodyPart: String, completion: @escaping (Result<[Exercise], NetworkError>) -> Void)
    mutating func fetchExerciseByEquipment(equipment: String, completion: @escaping (Result<[Exercise], NetworkError>) -> Void)
    mutating func fetchExerciseById(id: String, completion: @escaping (Result<Exercise, NetworkError>) -> Void)
}

struct ExerciseService: ExerciseServiceProtocol {
    private let network = Network()
    
    mutating func fetchAllExercises(completion: @escaping (Result<[Exercise], NetworkError>) -> Void) {
        network.performRequest(request: ExerciseRequest.fetchAllExercises, completion: completion)
    }
    
    mutating func fetchExerciseByBodyPart(bodyPart: String, completion: @escaping (Result<[Exercise], NetworkError>) -> Void) {
        network.performRequest(request: ExerciseRequest.fetchExerciseByBodyPart(bodyPart: bodyPart), completion: completion)
    }
    
    mutating func fetchExerciseByEquipment(equipment: String, completion: @escaping (Result<[Exercise], NetworkError>) -> Void) {
        network.performRequest(request: ExerciseRequest.fetchExerciseByEquipment(equipment: equipment), completion: completion)
    }
    
    mutating func fetchExerciseById(id: String, completion: @escaping (Result<Exercise, NetworkError>) -> Void) {
        network.performRequest(request: ExerciseRequest.fetchExerciseById(id: id), completion: completion)
    }
}
