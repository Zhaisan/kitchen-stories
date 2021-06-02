//
//  HomeCollectionCell.swift
//  FinalProject
//
//  Created by Amina Moldamyrza on 5/7/21.
//

import UIKit

class HomeCollectionCell: UICollectionViewCell {

    @IBOutlet weak var CellImageView: UIImageView!
    @IBOutlet weak var DescLabel: UILabel!
    
    func setup(card: Card){
        let url = URL(string: card.image!)
        let data = try? Data(contentsOf: url!)
        DescLabel.text = card.desc
        CellImageView.image = UIImage(data: data!)
        self.contentView.layer.cornerRadius = 20
    }
}
