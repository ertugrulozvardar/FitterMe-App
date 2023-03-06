//
//  UICollectionView+Extensions.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 18.01.2023.
//

import Foundation
import UIKit

extension UICollectionView {
    func registerNib(_ type: UICollectionViewCell.Type, bundle: Bundle) {
        register(UINib(nibName: type.identifier, bundle: bundle), forCellWithReuseIdentifier: type.identifier)
    }

    func dequeueCell<CellType: UICollectionViewCell>(type: CellType.Type, indexPath: IndexPath) -> CellType {
        guard let cell = dequeueReusableCell(withReuseIdentifier: CellType.identifier, for: indexPath) as? CellType else {
            fatalError("Wrong type of cell \(type)")
            }
        return cell
    }
}

