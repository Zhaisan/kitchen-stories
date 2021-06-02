//
//  RecipesCollectionCell.swift
//  FinalProject
//
//  Created by Amina Moldamyrza on 5/9/21.
//

import UIKit

class RecipesCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setup(recipe: RecipeData){
        let url = URL(string: recipe.image)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            imageView.image = UIImage(data: imageData)
        }
        likesLabel.text = "\(recipe.likes)"
        timeLabel.text = "\(recipe.prepTime)"
        titleLabel.text = recipe.title
        self.contentView.layer.cornerRadius = 20
    }
}
