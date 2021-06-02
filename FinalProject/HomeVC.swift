//
//  HomeVC.swift
//  FinalProject
//
//  Created by Amina Moldamyrza on 5/4/21.
//

import UIKit
import Foundation
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class HomeVC: UIViewController {
    
    let ref = Database.database().reference()
    
    var dataList: [Dictionary<String,Any>]?
    var currentUser: User?
    var cards: [Card] = []
    var recipes: [RecipeData] = []
    var rcps: [RecipeData] = []

    @IBOutlet weak var mainLikes: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var recipeCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref.child("card").observe(.value){[weak self] (snapshot) in
            self?.cards.removeAll()
            for child in snapshot.children{
                if let snap = child as? DataSnapshot{
                    var card = Card(snapshot: snap)
                    self?.cards.append(card)
                }
            }
            
            self?.cards.reverse()
            self?.cardCollectionView.reloadData()
        }
        ref.child("recipe").observe(.value){[weak self] (snapshot) in
            self?.recipes.removeAll()
            for child in snapshot.children{
                if let snap = child as? DataSnapshot{
                    let recipe = RecipeData(snapshot: snap)
                    self?.recipes.append(recipe)
                }
            }
            
            self?.recipes.sort(by: {$0.likes > $1.likes})
            self?.mainLabel.text = self?.recipes[0].title
            self?.mainLikes.text = "\(self?.recipes[0].likes as! Int)"
            self?.recipeCollectionView.reloadData()
        }
        mainCardView.layer.cornerRadius = 10
    }
    
    @IBAction func mainDetail(_ sender: Any) {
        RecipeDetailVC.thisRecipe = recipes[0]
        let controller = storyboard?.instantiateViewController(identifier: "ingredientDetail") as! UIViewController
        controller.modalPresentationStyle = .automatic
        controller.modalTransitionStyle = .flipHorizontal
        self.present(controller, animated: true, completion: nil)
    }
    
    
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case cardCollectionView:
            for recipe in recipes{
                if cards[indexPath.row].id == recipe.category_id{
                    RecipesVC.recipes.append(recipe)
                }
            }
        case recipeCollectionView:
            RecipeDetailVC.thisRecipe = recipes[indexPath.row]
            let controller = storyboard?.instantiateViewController(identifier: "ingredientDetail") as! UIViewController
            controller.modalPresentationStyle = .automatic
            controller.modalTransitionStyle = .flipHorizontal
            self.present(controller, animated: true, completion: nil)
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case cardCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! HomeCollectionCell
            cell.setup(card: cards[indexPath.row])
            return cell
        case recipeCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath) as! RecipesCollectionCell
            cell.setup(recipe: recipes[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case cardCollectionView:
            return cards.count
        case recipeCollectionView:
            return recipes.count
        default:
            return 0
        }
    }
    
}
