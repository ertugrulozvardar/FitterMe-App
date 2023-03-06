//
//  HomeExercisesTableViewCell.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 18.01.2023.
//

import UIKit

protocol HomeExercisesCellDelegate: AnyObject {
    func didSelectExercise(exercise: Exercise)
}

class HomeExercisesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var exerciseCollectionView: UICollectionView!
    
    var exercises:[Exercise] = []
    weak var delegate: HomeExercisesCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCollectionViewCells()
    }
    
    func registerCollectionViewCells() {
        exerciseCollectionView.registerNib(ExercisesCollectionViewCell.self, bundle: .main)
    }
    
    func configure(with exercises: [Exercise], delegate: HomeExercisesCellDelegate?) {
        self.exercises = exercises
        self.delegate = delegate
        self.exerciseCollectionView.reloadData()
    }
}

extension HomeExercisesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(type: ExercisesCollectionViewCell.self, indexPath: indexPath)
        cell.configure(exercise: exercises[indexPath.item])
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectExercise(exercise: exercises[indexPath.item])
    }
}

extension HomeExercisesTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 250)
    }
}

