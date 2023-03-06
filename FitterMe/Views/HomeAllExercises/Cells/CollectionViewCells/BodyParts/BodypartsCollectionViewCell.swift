//
//  BodypartsCollectionViewCell.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 17.01.2023.
//

import UIKit

class BodypartsCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var bodyPartsImageView: UIImageView!
    @IBOutlet weak var bodyPartsNameLabel: UILabel!
    
    func configure(bodyPart: String) {
        bodyPartsImageView.image = UIImage(named: bodyPart)
        bodyPartsNameLabel.text = bodyPart.capitalized
    }
}
