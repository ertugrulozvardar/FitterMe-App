//
//  ProgramExercise.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 10.02.2023.
//

import Foundation
import Firebase
import FirebaseDatabase

struct ProgramExercise {

    var exerciseName: String
    var exerciseId: String
    var reps: String
    var sets: String
    var day: String
    var isDone: Bool
   
    init(exerciseName: String, exerciseId: String, reps: String, sets: String, day: String, isDone: Bool) {
        self.exerciseName = exerciseName
        self.exerciseId = exerciseId
        self.reps = reps
        self.sets = sets
        self.day = day
        self.isDone = isDone
    }
    
    init(snapshot: DataSnapshot) {
        
        let snapshotValue = snapshot.value as! [String:AnyObject]
        
        exerciseName = snapshotValue["exerciseName"] as! String
        exerciseId = snapshotValue["exerciseId"] as! String
        reps = snapshotValue["reps"] as! String
        sets = snapshotValue["sets"] as! String
        day = snapshotValue["day"] as! String
        isDone = snapshotValue["isDone"] as! Bool
    }
    
    var nameUppercased: String {
        return exerciseName.capitalized
    }
}
