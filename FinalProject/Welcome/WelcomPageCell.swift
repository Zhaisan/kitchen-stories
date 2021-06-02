//
//  WelcomePageCell.swift
//  FinalProject
//
//  Created by Zhaisan on 09.05.2021.
//

import UIKit

class WelcomPageCell: UICollectionViewCell {
    
        @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var titleLabel: UILabel!
        @IBOutlet weak var descLabel: UILabel!

        func setup(_ slide: Slide){
            imageView.image = slide.image
            titleLabel.text = slide.title
            descLabel.text = slide.description
        }
}
