//
//  Exercise.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 14.01.2023.
//

import Foundation

struct Exercise: Codable {
    let bodyPart: String?
    let equipment: String?
    let gifUrl: String?
    let id: String?
    let name: String?
    let target: String?
    
    enum CodingKeys: String, CodingKey {
        case bodyPart
        case equipment
        case gifUrl
        case id
        case name
        case target
    }
    
    var httpsURL: String {
        let fourthIndex = (gifUrl?.index(gifUrl!.startIndex, offsetBy: 4))!
        var url = gifUrl
        url?.insert("s", at: fourthIndex)
        return url!
    }
    
    var nameUppercased: String {
        return name!.capitalized
    }
    
    var bodyPartUppercased: String {
        return bodyPart!.capitalized
    }
    
    var targetUppercased: String {
        return target!.capitalized
    }
    
    var equipmentUppercased: String {
        return equipment!.capitalized
    }
}
