//
//  HomeMyProgramTableViewCell.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 10.02.2023.
//

import UIKit

class HomeMyProgramTableViewCell: UITableViewCell {

    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var setsNameLabel: UILabel!
    @IBOutlet weak var repsNameLabel: UILabel!
    
    @IBOutlet weak var isDoneButton: UIButton! {
        didSet {
            if self.exercise?.isDone == true {
                isDoneButton.setImage(UIImage(named: "checkmark.circle.fill"), for: .normal)
            } else {
                isDoneButton.setImage(UIImage(named: "circlebadge"), for: .normal)
            }
        }
    }
    
    var exercise: ProgramExercise?
    private let homeMyProgramViewModel = HomeMyProgramViewModel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func changeButtonIconCondition(exercise: ProgramExercise?, button: UIButton) {
        self.exercise = exercise
        guard let exerciseId = self.exercise?.exerciseId else { return }
        if exercise?.isDone == true {
            self.exercise?.isDone = false
            homeMyProgramViewModel.updateExerciseWhenDone(child: exerciseId, isDone: false)
            button.setImage(UIImage(systemName: "circlebadge"), for: .normal)
        } else {
            self.exercise?.isDone = true
            homeMyProgramViewModel.updateExerciseWhenDone(child: exerciseId, isDone: true)
            button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }
    }
    
    @IBAction func isDoneButtonPressed(_ sender: UIButton) {
        changeButtonIconCondition(exercise: exercise, button: sender)
    }
    
    func configure(exercise: ProgramExercise?) {
        self.exercise = exercise
        exerciseNameLabel.text = exercise?.nameUppercased
        setsNameLabel.text = exercise?.sets
        repsNameLabel.text = exercise?.reps
    }
    
}
