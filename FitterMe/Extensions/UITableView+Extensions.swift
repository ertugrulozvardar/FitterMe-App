//
//  UITableView+Extensions.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 18.01.2023.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerNib(_ type: UITableViewCell.Type, bundle: Bundle) {
        register(
            
            UINib(nibName: type.identifier, bundle: bundle),
            forCellReuseIdentifier: type.identifier
            
        )
    }
    
    func dequeueCell<CellType: UITableViewCell>(type: CellType.Type, indexPath: IndexPath) -> CellType {
        guard let cell = dequeueReusableCell(withIdentifier: CellType.identifier, for: indexPath) as? CellType else {
            fatalError("Wrong type of cell \(type)")
            }
        return cell
    }
}

extension UIView {class var identifier: String {
    String(describing: self)
}}
