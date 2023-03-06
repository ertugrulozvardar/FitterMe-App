//
//  HomeBodyPartsTableViewCell.swift
//  FitterMe
//
//  Created by ertugrul.ozvardar on 18.01.2023.
//

import UIKit

protocol HomeBodyPartsCellDelegate: AnyObject {
    func didSelectBodyPart(bodyPart: String)
}

class HomeBodyPartsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bodyPartCollectionView: UICollectionView!
    
    var bodyParts:[String] = []
    weak var delegate: HomeBodyPartsCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        registerCollectionViewCells()
    }
    
    func registerCollectionViewCells() {
        bodyPartCollectionView.registerNib(BodypartsCollectionViewCell.self, bundle: .main)
    }
    
    func configure(with bodyParts: [String], delegate: HomeBodyPartsCellDelegate?) {
        self.bodyParts = bodyParts
        self.delegate = delegate
        self.bodyPartCollectionView.reloadData()
    }
    
}

extension HomeBodyPartsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bodyParts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(type: BodypartsCollectionViewCell.self, indexPath: indexPath)
        cell.configure(bodyPart: bodyParts[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectBodyPart(bodyPart: bodyParts[indexPath.item])
    }
}

extension HomeBodyPartsTableViewCell: UICollectionViewDelegateFlowLayout {
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


