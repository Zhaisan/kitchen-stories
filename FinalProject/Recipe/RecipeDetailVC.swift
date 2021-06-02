//
//  RecipeDetailVC.swift
//  FinalProject
//
//  Created by Amina Moldamyrza on 5/13/21.
//

import UIKit
import CoreData
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class RecipeDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var descText: UITextView!
    @IBOutlet weak var difficultyTitle: UILabel!
    @IBOutlet weak var cookingTitle: UILabel!
    @IBOutlet weak var backingTitle: UILabel!
    @IBOutlet weak var recipeTableView: UITableView!
    @IBOutlet weak var stepsText: UITextView!
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var save: UIButton!
    
    
    public static var thisRecipe: RecipeData?
    public static var likedRecipe: [RecipeData] = []
    public static var savedRecipe: [RecipeData] = []
    public static var shoppingListRecipes: [RecipeData] = []
    let ref = Database.database().reference()
    var ingredients: [String] = []
    static var liked: Bool = false
    static var saved: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: RecipeDetailVC.thisRecipe!.image)
        let data = try? Data(contentsOf: url!)
        authorLabel.text = RecipeDetailVC.thisRecipe?.author
        likeLabel.text = "\(RecipeDetailVC.thisRecipe!.likes as Int)"
        titleLabel.text = RecipeDetailVC.thisRecipe?.title
        backgroundImage.image = UIImage(data: data!)
        descText.text = RecipeDetailVC.thisRecipe?.desc
        difficultyTitle.text = RecipeDetailVC.thisRecipe?.difficulty
        cookingTitle.text = RecipeDetailVC.thisRecipe?.prepTime
        backingTitle.text = RecipeDetailVC.thisRecipe?.restingTime
        stepsText.text = RecipeDetailVC.thisRecipe?.steps
        ingredients = RecipeDetailVC.thisRecipe!.ingredients
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as! RecipeIngredientCell
        cell.ttl.text = ingredients[indexPath.row]
        return cell
    }

    @IBAction func saveButton(_ sender: Any) {
        RecipeDetailVC.saved = !RecipeDetailVC.saved
        if RecipeDetailVC.saved{
            save.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            RecipeDetailVC.savedRecipe.append(RecipeDetailVC.thisRecipe!)
        }else{
            save.setImage(UIImage(systemName: "bookmark"), for: .normal)
            RecipeDetailVC.savedRecipe.removeLast()
        }
//        saveGOT()
    }
    
    @IBAction func likeButton(_ sender: Any) {
        RecipeDetailVC.liked = !RecipeDetailVC.liked
        if RecipeDetailVC.liked{
            like.tintColor = .red
            like.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            RecipeDetailVC.thisRecipe!.likes += 1
            RecipeDetailVC.likedRecipe.append(RecipeDetailVC.thisRecipe!)
        }else{
            like.tintColor = .black
            like.setImage(UIImage(systemName: "heart"), for: .normal)
            RecipeDetailVC.thisRecipe!.likes -= 1
            RecipeDetailVC.likedRecipe.removeLast()
        }
        likeLabel.text = "\(RecipeDetailVC.thisRecipe!.likes as Int)"
//        saveGOT(whichOne: "LikeRecipe", toArray: "Like")
    }
    
    @IBAction func addButton(_ sender: Any) {
        RecipeDetailVC.shoppingListRecipes.append(RecipeDetailVC.thisRecipe!)
        let vc = ShoppingLIstTVC()
        vc.viewDidLoad()
    }
    
//    func saveGOT(){
//        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
//            let context = appDelegate.persistentContainer.viewContext
//            if let entity = NSEntityDescription.entity(forEntityName: "SavedRecipe", in: context){
//                let rcp = NSManagedObject(entity: entity, insertInto: context)
//                rcp.setValue(RecipeDetailVC.thisRecipe?.author, forKey: "author")
//                rcp.setValue(RecipeDetailVC.thisRecipe?.title, forKey: "title")
//                rcp.setValue(RecipeDetailVC.thisRecipe?.desc, forKey: "desc")
//                rcp.setValue(RecipeDetailVC.thisRecipe?.difficulty, forKey: "difficulty")
//                rcp.setValue(RecipeDetailVC.thisRecipe!.image, forKey: "image")
//                rcp.setValue(RecipeDetailVC.thisRecipe!.ingredients, forKey: "ingredients")
//                rcp.setValue(RecipeDetailVC.thisRecipe!.likes, forKey: "likes")
//                rcp.setValue(RecipeDetailVC.thisRecipe?.portion, forKey: "portion")
//                rcp.setValue(RecipeDetailVC.thisRecipe?.steps, forKey: "steps")
//                rcp.setValue(RecipeDetailVC.thisRecipe?.prepTime, forKey: "prepTime")
//                do {
//                    try context.save()
//                    RecipeDetailVC.savedRecipe.append((rcp as? RecipeData)!)
//                }
//                catch {}
//            }
//        }
//    }
    
}
