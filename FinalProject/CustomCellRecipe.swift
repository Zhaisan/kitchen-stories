//
//  CustomCellRecipe.swift
//  FinalProject
//
//  Created by Zhaisan on 31.05.2021.
//

import Foundation


import UIKit

class CustomCellRecipe: UITableViewCell {

    
    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeSubtitle: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
