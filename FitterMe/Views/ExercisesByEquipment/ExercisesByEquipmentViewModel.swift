//
//  ExercisesByEquipmentViewModel.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 23.01.2023.
//

import Foundation

final class ExercisesByEquipmentViewModel {
    
    private var exerciseService: ExerciseServiceProtocol = ExerciseService()
    var exercisesByEquipment = Observable<[Exercise]>()
    var searchedExercisesByEquipment = Observable<[Exercise]>()
    var isFetching = Observable<Bool>()
    
    func fetchAllExercisesByEquipment(with selectedEquipment: String) {
        isFetching.value = true
        exerciseService.fetchExerciseByEquipment(equipment: selectedEquipment) { [weak self] result in
            switch result {
            case .success(let response):
                self?.exercisesByEquipment.value = response
                self?.searchedExercisesByEquipment.value = response
                self?.isFetching.value = false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
