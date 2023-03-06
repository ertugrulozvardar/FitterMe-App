//
//  ExercisesByBodyPartViewController.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 16.01.2023.
//

import UIKit

class ExercisesByBodyPartViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var exercisesCollectionView: UICollectionView!
    
    private let exercisesByBodyPartViewModel = ExercisesByBodyPartViewModel()
    let loadingIndicator = UIActivityIndicatorView(style: .large)
    var selectedBodyPart: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewCells()
        setupLoadingIndicator()
        setupExercisesViewModelObserver()
        getAllExercisesByBodyPart(selectedBodyPart: selectedBodyPart)
    }
    
    fileprivate func setupExercisesViewModelObserver() {
        exercisesByBodyPartViewModel.exercisesByBodyPart.bind { [weak self] (_) in
            DispatchQueue.main.async {
                self?.exercisesCollectionView.reloadData()
            }
        }
        
        exercisesByBodyPartViewModel.isFetching.bind { [weak self] (isFetching) in
            guard let isFetching = isFetching else { return }
            DispatchQueue.main.async {
                isFetching ? self?.loadingIndicator.startAnimating() : self?.loadingIndicator.stopAnimating()
                self?.loadingIndicator.isHidden = !isFetching
            }
        }
    }
    
    fileprivate func setupLoadingIndicator() {
        loadingIndicator.color = .lightGray
        view.addSubview(loadingIndicator)
        //loadingIndicator.centerInSuperview(size: .init(width: 60, height: 60))
    }
    
    func registerCollectionViewCells() {
        exercisesCollectionView.registerNib(ExerciseByBodyCollectionViewCell.self, bundle: .main)
    }
    
    func getAllExercisesByBodyPart(selectedBodyPart: String?) {
        if let bodyPart = selectedBodyPart {
            exercisesByBodyPartViewModel.fetchAllExercisesByBodyPart(with: bodyPart)
        }
    }
}

//MARK: -UICollectionView Methods
extension ExercisesByBodyPartViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exercisesByBodyPartViewModel.searchedExercisesByBodyPart.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let exerciseCell = collectionView.dequeueCell(type: ExerciseByBodyCollectionViewCell.self, indexPath: indexPath)
        let exercise: Exercise?
        exercise = exercisesByBodyPartViewModel.searchedExercisesByBodyPart.value?[indexPath.item]
        exerciseCell.configure(exercise: exercise!)
        exerciseCell.layer.borderWidth = 2
        exerciseCell.layer.borderColor = UIColor.black.cgColor
        return exerciseCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let exercisesByIdVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ExercisesByIdViewController.self)) as? ExercisesByIdViewController {
            let exercise: Exercise?
            exercise = exercisesByBodyPartViewModel.searchedExercisesByBodyPart.value?[indexPath.item]
            exercisesByIdVC.exerciseId = exercise?.id
            self.navigationController?.pushViewController(exercisesByIdVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 50)/2
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

//MARK: SearchBar Delegate Methods
extension ExercisesByBodyPartViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.exercisesByBodyPartViewModel.searchedExercisesByBodyPart.value = self.exercisesByBodyPartViewModel.exercisesByBodyPart.value
        }
        self.exercisesByBodyPartViewModel.searchedExercisesByBodyPart.value = []
        guard let exercises = self.exercisesByBodyPartViewModel.exercisesByBodyPart.value else { return }
        for exercise in exercises {
            if searchBar.text == "" {
                exercisesByBodyPartViewModel.searchedExercisesByBodyPart.value = exercisesByBodyPartViewModel.exercisesByBodyPart.value
            } else {
                if exercise.name!.lowercased().contains(searchBar.text!.lowercased()) {
                    self.exercisesByBodyPartViewModel.searchedExercisesByBodyPart.value?.append(exercise)
                }
            }
        }
        exercisesCollectionView.reloadData()
    }
}
