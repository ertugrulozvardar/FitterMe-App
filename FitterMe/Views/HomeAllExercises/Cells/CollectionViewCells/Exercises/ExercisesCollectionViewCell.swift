//
//  ExercisesCollectionViewCell.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 17.01.2023.
//

import UIKit
import Kingfisher

class ExercisesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    
    func configure(exercise: Exercise) {
        exerciseImageView.kf.indicatorType = .activity
        exerciseImageView.kf.setImage(with: URL(string: exercise.httpsURL)!)
        exerciseNameLabel.text = exercise.nameUppercased
    }
}
