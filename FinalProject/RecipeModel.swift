//
//  RecipeModel.swift
//  FinalProject
//
//  Created by Zhaisan on 31.05.2021.
//

import Foundation

import Foundation
import UIKit

class RecipeModel{
    var title: String?
    var subtitle: String?
    var image: UIImage?
    init(_ title: String, _ subtitle: String, _ image: UIImage){
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
}
