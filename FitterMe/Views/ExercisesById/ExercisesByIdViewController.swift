//
//  ExercisesByIdViewController.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 16.01.2023.
//

import UIKit

class ExercisesByIdViewController: UIViewController {
    
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var bodyPartNameLabel: UILabel!
    @IBOutlet weak var equipmentNameLabel: UILabel!
    @IBOutlet weak var targetMuscleNameLabel: UILabel!
    @IBOutlet weak var setNumberPickerView: UIPickerView! {
        didSet {
            setNumberPickerView.tag = 1
            setNumberPickerView.delegate = self
            setNumberPickerView.dataSource = self
        }
    }
    @IBOutlet weak var repNumberPickerView: UIPickerView! {
        didSet {
            repNumberPickerView.tag = 2
            repNumberPickerView.delegate = self
            repNumberPickerView.dataSource = self
        }
    }
    
    @IBOutlet weak var dayPickerView: UIPickerView! {
        didSet {
            dayPickerView.tag = 3
            dayPickerView.delegate = self
            dayPickerView.dataSource = self
        }
    }
    
    @IBAction func addToProgramButtonClicked(_ sender: UIButton) {
        if let exerciseById = exercisesByIdViewModel.exerciseById.value {
            exercisesByIdViewModel.addNewExerciseToProgram(exerciseId: exerciseById.id!, exerciseName: exerciseById.name!, setsNumber: selectedSet, repsNumber: selectedRep, selectedDay: selectedDay, isDone: false)
        }
        
        let alert = UIAlertController(title: "SUCCESS!", message: "Exercise has been added to your program.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addToFavoritesButtonClicked(_ sender: UIButton) {
    }
    
    private let exercisesByIdViewModel = ExercisesByIdViewModel()
    let loadingIndicator = UIActivityIndicatorView(style: .large)
    var exerciseId: String?
    var selectedSet: String = ""
    var selectedRep: String = ""
    var selectedDay: String = ""
    let sets: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    let reps: [String] = ["3", "5", "6", "7", "8", "9", "10", "12", "15", "20"]
    let days: [String] = ["Monday" , "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingIndicator()
        setupExercisesViewModelObserver()
        getExerciseById(exerciseId: exerciseId)
    }
    
    fileprivate func setupExercisesViewModelObserver() {
        exercisesByIdViewModel.exerciseById.bind { [weak self] (_) in
            self?.updateUIElements(exercise: self?.exercisesByIdViewModel.exerciseById)
        }
        
        exercisesByIdViewModel.isFetching.bind { [weak self] (isFetching) in
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
    
    func getExerciseById(exerciseId: String?) {
        if let id = exerciseId {
            exercisesByIdViewModel.fetchExerciseById(with: id)
        }
    }
    
    func updateUIElements(exercise: Observable<Exercise>?) {
        if let finalExercise = exercise {
            exerciseNameLabel.text = finalExercise.value?.nameUppercased
            exerciseImageView.kf.indicatorType = .activity
            guard let url = finalExercise.value?.httpsURL else {return}
            exerciseImageView.kf.setImage(with: URL(string: url))
            bodyPartNameLabel.text = finalExercise.value?.bodyPartUppercased
            equipmentNameLabel.text = finalExercise.value?.equipmentUppercased
            targetMuscleNameLabel.text = finalExercise.value?.targetUppercased
        }
    }

}

extension ExercisesByIdViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var rowNumber: Int
        switch pickerView.tag {
        case 1:
            rowNumber = sets.count
        case 2:
            rowNumber = reps.count
        case 3:
            rowNumber = days.count
        default:
            rowNumber = 1
        }
        return rowNumber
    }
}

extension ExercisesByIdViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var rowTitle: String?
        switch pickerView.tag {
        case 1:
            rowTitle = sets[row]
        case 2:
            rowTitle = reps[row]
        case 3:
            rowTitle = days[row]
        default:
            rowTitle = "Default"
        }
        return rowTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            selectedSet = String(sets[row])
        case 2:
            selectedRep = String(reps[row])
        case 3:
            selectedDay = String(days[row])
        default:
            break
        }
    }
}
