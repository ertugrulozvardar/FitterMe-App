//
//  TableViewSections.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 20.01.2023.
//

import Foundation

enum TableViewSections: Int, CaseIterable {
    case bodyParts
    case exercises
    case equipments
}

func getSections(section: TableViewSections) -> String {
    switch section {
    case .bodyParts:
        return "Body Parts"
    case .exercises:
        return "All Exercises"
    case .equipments:
        return "Equipments"
    default:
        break
    }
}
