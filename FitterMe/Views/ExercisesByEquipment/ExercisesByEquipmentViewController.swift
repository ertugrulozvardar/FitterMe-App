//
//  ExercisesByEquipmentViewController.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 16.01.2023.
//

import UIKit

class ExercisesByEquipmentViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var exercisesCollectionView: UICollectionView!
    
    private let exercisesByEquipmentViewModel = ExercisesByEquipmentViewModel()
    let loadingIndicator = UIActivityIndicatorView(style: .large)
    var selectedEquipment: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewCells()
        setupLoadingIndicator()
        setupExercisesViewModelObserver()
        getAllExercisesByEquipment(selectedEquipment: selectedEquipment)
    }
    
    fileprivate func setupExercisesViewModelObserver() {
        exercisesByEquipmentViewModel.exercisesByEquipment.bind { [weak self] (_) in
            DispatchQueue.main.async {
                self?.exercisesCollectionView.reloadData()
            }
        }
        
        exercisesByEquipmentViewModel.isFetching.bind { [weak self] (isFetching) in
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
        exercisesCollectionView.registerNib(ExercisesByEquipmentCollectionViewCell.self, bundle: .main)
    }
    
    func getAllExercisesByEquipment(selectedEquipment: String?) {
        if let equipment = selectedEquipment {
            exercisesByEquipmentViewModel.fetchAllExercisesByEquipment(with: equipment)
        }
    }
}

//MARK: -UICollectionView Methods
extension ExercisesByEquipmentViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exercisesByEquipmentViewModel.searchedExercisesByEquipment.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let exerciseCell = collectionView.dequeueCell(type: ExercisesByEquipmentCollectionViewCell.self, indexPath: indexPath)
        let exercise: Exercise?
        exercise = exercisesByEquipmentViewModel.searchedExercisesByEquipment.value?[indexPath.item]
        exerciseCell.configure(exercise: exercise!)
        exerciseCell.layer.borderWidth = 2
        exerciseCell.layer.borderColor = UIColor.black.cgColor
        return exerciseCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let exercisesByIdVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ExercisesByIdViewController.self)) as? ExercisesByIdViewController {
            let exercise: Exercise?
            exercise = exercisesByEquipmentViewModel.searchedExercisesByEquipment.value?[indexPath.item]
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
extension ExercisesByEquipmentViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.exercisesByEquipmentViewModel.searchedExercisesByEquipment.value = self.exercisesByEquipmentViewModel.exercisesByEquipment.value
        }
        self.exercisesByEquipmentViewModel.searchedExercisesByEquipment.value = []
        guard let exercises = self.exercisesByEquipmentViewModel.exercisesByEquipment.value else { return }
        for exercise in exercises {
            if searchBar.text == "" {
                exercisesByEquipmentViewModel.searchedExercisesByEquipment.value = exercisesByEquipmentViewModel.exercisesByEquipment.value
            } else {
                if exercise.name!.lowercased().contains(searchBar.text!.lowercased()) {
                    self.exercisesByEquipmentViewModel.searchedExercisesByEquipment.value?.append(exercise)
                }
            }
        }
        exercisesCollectionView.reloadData()
    }
}
