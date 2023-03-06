//
//  EquipmentsCollectionViewCell.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 17.01.2023.
//

import UIKit

class EquipmentsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var equipmentsImageView: UIImageView!
    @IBOutlet weak var equipmentsNameLabel: UILabel!
    
    func configure(equipment: String) {
        equipmentsImageView.image = UIImage(named: equipment)
        equipmentsNameLabel.text = equipment.capitalized
    }
}
