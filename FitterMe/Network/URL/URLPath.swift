//
//  URLPath.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 14.01.2023.
//

import Foundation

enum URLPath {
    case allExercises
    case exerciseByBodyPart
    case exerciseByEquipment
    case exerciseById
    case allBodyParts
    case allEquipments
}

func getURLPathName(path: URLPath, bodyPart: String, equipment: String, id: String) -> String? {
    switch path {
    case .allExercises:
        return "/exercises"
    case .exerciseByBodyPart:
        return "/exercises/bodyPart/\(bodyPart)"
    case .exerciseByEquipment:
        return "/exercises/equipment/\(equipment)"
    case .exerciseById:
        return "/exercises/exercise/\(id)"
    case .allBodyParts:
        return "/exercises/bodyPartList"
    case .allEquipments:
        return "/exercises/equipmentList"
    }
}
