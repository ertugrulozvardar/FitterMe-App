//
//  BodypartRequest.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 16.01.2023.
//

import Foundation

enum BodypartRequest {
    
    case fetchAllBodyParts
}

extension BodypartRequest: Requestable {
    var URLpath: String {
            var urlComponents = URLComponents(string: baseURL)!
            switch self {
            case .fetchAllBodyParts:
                urlComponents.path = getURLPathName(path: .allBodyParts, bodyPart: "", equipment: "", id: "") ?? "/exercises/bodyPartList"
                return urlComponents.string!
            }
        }
        
        var URLparameters: Data? {
            switch self {
            case .fetchAllBodyParts:
                return nil
            }
        }
}
