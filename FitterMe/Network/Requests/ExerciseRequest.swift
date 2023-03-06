//
//  ExerciseRequest.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 15.01.2023.
//

import Foundation

enum ExerciseRequest {
    
    case fetchAllExercises
    case fetchExerciseByBodyPart(bodyPart: String)
    case fetchExerciseByEquipment(equipment: String)
    case fetchExerciseById(id: String)
}

extension ExerciseRequest: Requestable {
    var URLpath: String {
            var urlComponents = URLComponents(string: baseURL)!
            switch self {
            case .fetchAllExercises:
                urlComponents.path = getURLPathName(path: .allExercises, bodyPart: "", equipment: "", id: "") ?? "/exercises"
                return urlComponents.string!
            case .fetchExerciseByBodyPart(let bodyPart):
                urlComponents.path = getURLPathName(path: .exerciseByBodyPart, bodyPart: bodyPart, equipment: "", id: "") ?? "/exercises"
                let url = urlComponents.string!
                let percentedURL = url.replacingOccurrences(of: " ", with: "%20")
                return percentedURL
            case .fetchExerciseByEquipment(let equipment):
                urlComponents.path = getURLPathName(path: .exerciseByEquipment, bodyPart: "", equipment: equipment, id: "") ?? "/exercises"
                let url = urlComponents.string!
                let percentedURL = url.replacingOccurrences(of: " ", with: "%20")
                return percentedURL
            case .fetchExerciseById(id: let id):
                urlComponents.path = getURLPathName(path: .exerciseById, bodyPart: "", equipment: "", id: id) ?? "/exercises"
                return urlComponents.string!
            }
        }
        
        var URLparameters: Data? {
            switch self {
            case .fetchAllExercises,
                 .fetchExerciseByBodyPart,
                 .fetchExerciseByEquipment,
                 .fetchExerciseById:
                return nil
            }
        }
}

