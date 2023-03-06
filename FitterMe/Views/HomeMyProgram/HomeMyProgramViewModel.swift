//
//  HomeMyProgramViewModel.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 10.02.2023.
//

import Foundation
import FirebaseDatabase

final class HomeMyProgramViewModel {
    
    
    private let database = Database.database().reference()
    var exercises = Observable<[ProgramExercise]>()
    var mondayExercises: [ProgramExercise] = []
    var tuesdayExercises: [ProgramExercise] = []
    var wednesdayExercises: [ProgramExercise] = []
    var thursdayExercises: [ProgramExercise] = []
    var fridayExercises: [ProgramExercise] = []
    var saturdayExercises: [ProgramExercise] = []
    var sundayExercises: [ProgramExercise] = []
    var isFetching = Observable<Bool>()
    
    let exercisesRef = Database.database().reference().child("Exercises")
    
    func fetchAllExercises() {
        
        exercisesRef.observe(.value, with: { snapshot in
            self.mondayExercises.removeAll()
            self.tuesdayExercises.removeAll()
            self.wednesdayExercises.removeAll()
            self.thursdayExercises.removeAll()
            self.fridayExercises.removeAll()
            self.saturdayExercises.removeAll()
            self.sundayExercises.removeAll()
            
            if ( snapshot.value is NSNull ) {
                print("not found")
            } else {
                
                var newItems: [ProgramExercise] = []
                
                for item in (snapshot.children) {
                    let exercisesItem = ProgramExercise(snapshot: item as! DataSnapshot)
                    newItems.append(exercisesItem)
                }
                self.exercises.value = newItems
                
                if let value = self.exercises.value {
                    for exercise in value {
                        switch exercise.day {
                        case getSections(section: .monday):
                            self.mondayExercises.append(exercise)
                        case getSections(section: .tuesday):
                            self.tuesdayExercises.append(exercise)
                        case getSections(section: .wednesday):
                            self.wednesdayExercises.append(exercise)
                        case getSections(section: .thursday):
                            self.thursdayExercises.append(exercise)
                        case getSections(section: .friday):
                            self.fridayExercises.append(exercise)
                        case getSections(section: .saturday):
                            self.saturdayExercises.append(exercise)
                        case getSections(section: .sunday):
                            self.sundayExercises.append(exercise)
                        default:
                            break
                        }
                    }
                    
                }
            }
        })
    }
    
    func removeExercise(child: String) {
        let ref = exercisesRef.child(child)
        ref.removeValue { error, _ in
            print(error?.localizedDescription ?? "Something went wrong while removing the exercise !")
        }
    }
    
    func updateExerciseWhenDone(child: String, isDone: Bool) {
        let ref = exercisesRef.child(child).child("isDone")
        ref.setValue(isDone)
    }
}
