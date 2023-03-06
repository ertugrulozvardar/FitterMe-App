//
//  ProgramTableSections.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 10.02.2023.
//

import Foundation

enum ProgramTableSections: Int, CaseIterable {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}

func getSections(section: ProgramTableSections) -> String {
    switch section {
    case .monday:
        return "Monday"
    case .tuesday:
        return "Tuesday"
    case .wednesday:
        return "Wednesday"
    case .thursday:
        return "Thursday"
    case .friday:
        return "Friday"
    case .saturday:
        return "Saturday"
    case .sunday:
        return "Sunday"
    default:
        break
    }
}
