//
//  HomeEquipmentsTableViewCell.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 18.01.2023.
//

import UIKit

protocol HomeEquipmentsCellDelegate: AnyObject {
    func didSelectEquipment(equipment: String)
}

class HomeEquipmentsTableViewCell: UITableViewCell {

    @IBOutlet weak var equipmentCollectionView: UICollectionView!
    
    var equipments:[String] = []
    weak var delegate: HomeEquipmentsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCollectionViewCells()
    }
    
    func registerCollectionViewCells() {
        equipmentCollectionView.registerNib(EquipmentsCollectionViewCell.self, bundle: .main)
    }
    
    func configure(with equipments: [String], delegate: HomeEquipmentsCellDelegate?) {
        self.equipments = equipments
        self.delegate = delegate
        self.equipmentCollectionView.reloadData()
    }
}

extension HomeEquipmentsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return equipments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(type: EquipmentsCollectionViewCell.self, indexPath: indexPath)
        cell.configure(equipment: equipments[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectEquipment(equipment: equipments[indexPath.item])
    }
}

extension HomeEquipmentsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 175)
    }
}

