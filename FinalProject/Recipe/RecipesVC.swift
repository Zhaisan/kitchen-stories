//
//  RecipesVC.swift
//  FinalProject
//
//  Created by Amina Moldamyrza on 5/10/21.
//

import UIKit

class RecipesVC: UIViewController {
    
    @IBOutlet weak var ListCollectionView: UICollectionView!
    
    static var recipes: [RecipeData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print(RecipesVC.recipes)
    }
    
}

extension RecipesVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RecipesVC.recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath) as! RecipesCollectionCell
        cell.setup(recipe: RecipesVC.recipes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        RecipeDetailVC.thisRecipe = RecipesVC.recipes[indexPath.row]
        let controller = storyboard?.instantiateViewController(identifier: "ingredientDetail") as! UIViewController
        controller.modalPresentationStyle = .automatic
        controller.modalTransitionStyle = .flipHorizontal
        self.present(controller, animated: true, completion: nil)
    }
}

extension RecipesVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let width: CGFloat = collectionView.frame.size.width
        let xInsets: CGFloat = 10
        let spacing: CGFloat = 5
        
        return CGSize(width: (width/numberOfColumns) - (xInsets + spacing), height: 410)
    }
}
