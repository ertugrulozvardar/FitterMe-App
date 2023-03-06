//
//  HomeAllExercisesViewController.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 15.01.2023.
//

import UIKit

class HomeAllExercisesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let homeAllExercisesViewModel = HomeAllExercisesViewModel()
    let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
        setupLoadingIndicator()
        setupExercisesViewModelObserver()
        getAllData()
    }
    
    fileprivate func setupExercisesViewModelObserver() {
        homeAllExercisesViewModel.exercises.bind { [weak self] (_) in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        homeAllExercisesViewModel.bodyParts.bind { [weak self] (_) in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        homeAllExercisesViewModel.equipments.bind { [weak self] (_) in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        homeAllExercisesViewModel.isFetching.bind { [weak self] (isFetching) in
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
    
    func registerTableViewCells() {
        tableView.registerNib(HomeBodyPartsTableViewCell.self, bundle: .main)
        tableView.registerNib(HomeExercisesTableViewCell.self, bundle: .main)
        tableView.registerNib(HomeEquipmentsTableViewCell.self, bundle: .main)
    }
    
    func getAllData() {
        getAllBodyParts()
        getAllExercises()
        getAllEquipments()
    }
    
    func getAllBodyParts() {
        homeAllExercisesViewModel.fetchAllBodyParts()
    }
    
    func getAllExercises() {
        homeAllExercisesViewModel.fetchAllExercises()
    }
    
    func getAllEquipments() {
        homeAllExercisesViewModel.fetchAllEquipments()
    }
}


//MARK: -UITableView Data Source
extension HomeAllExercisesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueCell(type: HomeBodyPartsTableViewCell.self, indexPath: indexPath)
            cell.configure(with: homeAllExercisesViewModel.bodyParts.value ?? [], delegate: self)
            return cell
        case 1:
            let cell = tableView.dequeueCell(type: HomeExercisesTableViewCell.self, indexPath: indexPath)
            cell.configure(with: homeAllExercisesViewModel.exercises.value ?? [], delegate: self)
            return cell
        case 2:
            let cell = tableView.dequeueCell(type: HomeEquipmentsTableViewCell.self, indexPath: indexPath)
            cell.configure(with: homeAllExercisesViewModel.equipments.value ?? [], delegate: self)
            return cell
        default:
            let cell = tableView.dequeueCell(type: HomeEquipmentsTableViewCell.self, indexPath: indexPath)
            cell.configure(with: homeAllExercisesViewModel.equipments.value ?? [], delegate: self)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch TableViewSections(rawValue: section) {
        case .bodyParts:
            return getSections(section: .bodyParts)
        case .exercises:
            return getSections(section: .exercises)
        case .equipments:
            return getSections(section: .equipments)
        default:
            return ""
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableViewSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .black
        header.textLabel?.frame = header.bounds
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
}

extension HomeAllExercisesViewController: HomeBodyPartsCellDelegate, HomeExercisesCellDelegate, HomeEquipmentsCellDelegate {
    
    func didSelectBodyPart(bodyPart: String) {
        if let exercisesByBodyPartVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ExercisesByBodyPartViewController.self)) as? ExercisesByBodyPartViewController {
            exercisesByBodyPartVC.selectedBodyPart = bodyPart
            self.navigationController?.pushViewController(exercisesByBodyPartVC, animated: true)
        }
    }
    
    func didSelectExercise(exercise: Exercise) {
        if let exercisesByIdVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ExercisesByIdViewController.self)) as? ExercisesByIdViewController {
            exercisesByIdVC.exerciseId = exercise.id
            self.navigationController?.pushViewController(exercisesByIdVC, animated: true)
        }
    }
    
    func didSelectEquipment(equipment: String) {
        if let exercisesByEquipmentVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ExercisesByEquipmentViewController.self)) as? ExercisesByEquipmentViewController {
            exercisesByEquipmentVC.selectedEquipment = equipment
            self.navigationController?.pushViewController(exercisesByEquipmentVC, animated: true)
        }
    }
}
