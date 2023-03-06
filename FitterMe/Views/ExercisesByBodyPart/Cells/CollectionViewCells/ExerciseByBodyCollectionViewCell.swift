//
//  ExerciseByBodyCollectionViewCell.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 20.01.2023.
//

import UIKit

class ExerciseByBodyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(exercise: Exercise) {
        exerciseImageView.kf.indicatorType = .activity
        exerciseImageView.kf.setImage(with: URL(string: exercise.httpsURL)!)
        exerciseNameLabel.text = exercise.nameUppercased
    }
}
