//
//  EquipmentRequest.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 16.01.2023.
//

import Foundation

enum EquipmentRequest {
    
    case fetchAllEquipments
}

extension EquipmentRequest: Requestable {
    var URLpath: String {
            var urlComponents = URLComponents(string: baseURL)!
            switch self {
            case .fetchAllEquipments:
                urlComponents.path = getURLPathName(path: .allEquipments, bodyPart: "", equipment: "", id: "") ?? "/exercises/equipmentList"
                return urlComponents.string!
            }
        }
        
        var URLparameters: Data? {
            switch self {
            case .fetchAllEquipments:
                return nil
            }
        }
}

