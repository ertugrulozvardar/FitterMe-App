//
//  ExercisesByBodyPartViewModel.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 20.01.2023.
//

import Foundation

final class ExercisesByBodyPartViewModel {
    
    private var exerciseService: ExerciseServiceProtocol = ExerciseService()
    var exercisesByBodyPart = Observable<[Exercise]>()
    var searchedExercisesByBodyPart = Observable<[Exercise]>()
    var isFetching = Observable<Bool>()
    
    func fetchAllExercisesByBodyPart(with selectedBodyPart: String) {
        isFetching.value = true
        exerciseService.fetchExerciseByBodyPart(bodyPart: selectedBodyPart) { [weak self] result in
            switch result {
            case .success(let response):
                self?.exercisesByBodyPart.value = response
                self?.searchedExercisesByBodyPart.value = response
                self?.isFetching.value = false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
