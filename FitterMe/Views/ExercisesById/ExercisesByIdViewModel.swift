//
//  ExercisesByIdViewModel.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 23.01.2023.
//

import Foundation
import FirebaseDatabase

final class ExercisesByIdViewModel {
    
    private let database = Database.database().reference()
    
    private var exerciseService: ExerciseServiceProtocol = ExerciseService()
    var exerciseById = Observable<Exercise>()
    var isFetching = Observable<Bool>()
    let exercisesRef = Database.database().reference().child("Exercises")
    
    func fetchExerciseById(with selectedId: String) {
        isFetching.value = true
        exerciseService.fetchExerciseById(id: selectedId) { [weak self] result in
            switch result {
            case .success(let response):
                self?.exerciseById.value = response
                self?.isFetching.value = false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addNewExerciseToProgram(exerciseId: String, exerciseName: String, setsNumber: String, repsNumber: String, selectedDay: String, isDone: Bool) {
        let object: [String: Any] = [
            "exerciseName": exerciseName,
            "exerciseId": exerciseId,
            "sets": setsNumber,
            "reps": repsNumber,
            "day": selectedDay,
            "isDone": isDone,
        ]
        exercisesRef.child(exerciseId).setValue(object)
    }

}
