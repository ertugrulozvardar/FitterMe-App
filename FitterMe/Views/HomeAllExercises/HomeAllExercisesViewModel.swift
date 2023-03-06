//
//  HomeAllExercisesViewModel.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 17.01.2023.
//

import Foundation

final class HomeAllExercisesViewModel {
    
    private var exerciseService: ExerciseServiceProtocol = ExerciseService()
    private var bodyPartService: BodyPartServiceProtocol = BodyPartService()
    private var equipmentService: EquipmentServiceProtocol = EquipmentService()
    var exercises = Observable<[Exercise]>()
    var bodyParts = Observable<[String]>()
    var equipments = Observable<[String]>()
    var isFetching = Observable<Bool>()
    
    func fetchAllExercises() {
        isFetching.value = true
        exerciseService.fetchAllExercises { [weak self] result in
            switch result {
            case .success(let response):
                self?.exercises.value = response
                self?.isFetching.value = false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchAllBodyParts() {
        isFetching.value = true
        bodyPartService.fetchAllBodyParts { [weak self] result in
            switch result {
            case .success(let response):
                self?.bodyParts.value = response
                self?.isFetching.value = false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchAllEquipments() {
        isFetching.value = true
        equipmentService.fetchAllEquipments { [weak self] result in
            switch result {
            case .success(let response):
                self?.equipments.value = response
                self?.isFetching.value = false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
