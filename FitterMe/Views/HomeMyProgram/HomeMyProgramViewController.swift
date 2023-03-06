//
//  HomeMyProgramViewController.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 10.02.2023.
//

import UIKit

class HomeMyProgramViewController: UIViewController {
    
    @IBOutlet weak var homeMyProgramTableView: UITableView!
    
    private let homeMyProgramViewModel = HomeMyProgramViewModel()
    let loadingIndicator = UIActivityIndicatorView(style: .large)
    var exerciseId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
        setupLoadingIndicator()
        setupExercisesViewModelObserver()
        getAllExercises()
    }
    
    fileprivate func setupExercisesViewModelObserver() {
        homeMyProgramViewModel.exercises.bind { [weak self] (_) in
            DispatchQueue.main.async {
                self?.homeMyProgramTableView.reloadData()
            }
        }
        
        homeMyProgramViewModel.isFetching.bind { [weak self] (isFetching) in
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
        homeMyProgramTableView.registerNib(HomeMyProgramTableViewCell.self, bundle: .main)
    }
    
    func getAllExercises() {
        homeMyProgramViewModel.fetchAllExercises()
    }
}

//MARK: -UITableView Data Source
extension HomeMyProgramViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch ProgramTableSections(rawValue: section) {
        case .monday:
            return homeMyProgramViewModel.mondayExercises.count
        case .tuesday:
            return homeMyProgramViewModel.tuesdayExercises.count
        case .wednesday:
            return homeMyProgramViewModel.wednesdayExercises.count
        case .thursday:
            return homeMyProgramViewModel.thursdayExercises.count
        case .friday:
            return homeMyProgramViewModel.fridayExercises.count
        case .saturday:
            return homeMyProgramViewModel.saturdayExercises.count
        case .sunday:
            return homeMyProgramViewModel.sundayExercises.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: HomeMyProgramTableViewCell.self, indexPath: indexPath)
        switch ProgramTableSections(rawValue: indexPath.section) {
        case .monday:
            let exercise = homeMyProgramViewModel.mondayExercises[indexPath.row]
            cell.configure(exercise: exercise)
            return cell
        case .tuesday:
            let exercise = homeMyProgramViewModel.tuesdayExercises[indexPath.row]
            cell.configure(exercise: exercise)
            return cell
        case .wednesday:
            let exercise = homeMyProgramViewModel.wednesdayExercises[indexPath.row]
            cell.configure(exercise: exercise)
            return cell
        case .thursday:
            let exercise = homeMyProgramViewModel.thursdayExercises[indexPath.row]
            cell.configure(exercise: exercise)
            return cell
        case .friday:
            let exercise = homeMyProgramViewModel.fridayExercises[indexPath.row]
            cell.configure(exercise: exercise)
            return cell
        case .saturday:
            let exercise = homeMyProgramViewModel.saturdayExercises[indexPath.row]
            cell.configure(exercise: exercise)
            return cell
        case .sunday:
            let exercise = homeMyProgramViewModel.sundayExercises[indexPath.row]
            cell.configure(exercise: exercise)
            return cell
        default:
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch ProgramTableSections(rawValue: section) {
        case .monday:
            return getSections(section: .monday)
        case .tuesday:
            return getSections(section: .tuesday)
        case .wednesday:
            return getSections(section: .wednesday)
        case .thursday:
            return getSections(section: .thursday)
        case .friday:
            return getSections(section: .friday)
        case .saturday:
            return getSections(section: .saturday)
        case .sunday:
            return getSections(section: .sunday)
        default:
            return ""
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ProgramTableSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let exercisesByIdVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ExercisesByIdViewController.self)) as? ExercisesByIdViewController {
            switch ProgramTableSections(rawValue: indexPath.section) {
            case .monday:
                let exercise = homeMyProgramViewModel.mondayExercises[indexPath.row]
                exercisesByIdVC.exerciseId = exercise.exerciseId
            case .tuesday:
                let exercise = homeMyProgramViewModel.tuesdayExercises[indexPath.row]
                exercisesByIdVC.exerciseId = exercise.exerciseId
            case .wednesday:
                let exercise = homeMyProgramViewModel.wednesdayExercises[indexPath.row]
                exercisesByIdVC.exerciseId = exercise.exerciseId
            case .thursday:
                let exercise = homeMyProgramViewModel.thursdayExercises[indexPath.row]
                exercisesByIdVC.exerciseId = exercise.exerciseId
            case .friday:
                let exercise = homeMyProgramViewModel.fridayExercises[indexPath.row]
                exercisesByIdVC.exerciseId = exercise.exerciseId
            case .saturday:
                let exercise = homeMyProgramViewModel.saturdayExercises[indexPath.row]
                exercisesByIdVC.exerciseId = exercise.exerciseId
            case .sunday:
                let exercise = homeMyProgramViewModel.sundayExercises[indexPath.row]
                exercisesByIdVC.exerciseId = exercise.exerciseId
            default:
                break
            }
            self.navigationController?.pushViewController(exercisesByIdVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            switch ProgramTableSections(rawValue: indexPath.section) {
            case .monday:
                homeMyProgramViewModel.removeExercise(child:  homeMyProgramViewModel.mondayExercises[indexPath.row].exerciseId)
                homeMyProgramViewModel.mondayExercises.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            case .tuesday:
                homeMyProgramViewModel.removeExercise(child:  homeMyProgramViewModel.tuesdayExercises[indexPath.row].exerciseId)
                homeMyProgramViewModel.tuesdayExercises.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            case .wednesday:
                homeMyProgramViewModel.removeExercise(child:  homeMyProgramViewModel.wednesdayExercises[indexPath.row].exerciseId)
                homeMyProgramViewModel.wednesdayExercises.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            case .thursday:
                homeMyProgramViewModel.removeExercise(child:  homeMyProgramViewModel.thursdayExercises[indexPath.row].exerciseId)
                homeMyProgramViewModel.thursdayExercises.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            case .friday:
                homeMyProgramViewModel.removeExercise(child:  homeMyProgramViewModel.fridayExercises[indexPath.row].exerciseId)
                homeMyProgramViewModel.fridayExercises.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            case .saturday:
                homeMyProgramViewModel.removeExercise(child:  homeMyProgramViewModel.saturdayExercises[indexPath.row].exerciseId)
                homeMyProgramViewModel.saturdayExercises.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            case .sunday:
                homeMyProgramViewModel.removeExercise(child:  homeMyProgramViewModel.sundayExercises[indexPath.row].exerciseId)
                homeMyProgramViewModel.sundayExercises.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            default:
                break
            }
            tableView.reloadData()
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let additionalSeparatorThickness = CGFloat(3)
        let additionalSeparator = UIView(frame: CGRectMake(0,
                                                           cell.frame.size.height - additionalSeparatorThickness,
                                                           cell.frame.size.width,
                                                           additionalSeparatorThickness))
        additionalSeparator.backgroundColor = .black
        cell.addSubview(additionalSeparator)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .orange
        header.textLabel?.frame = header.bounds
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 22)
    }
}
