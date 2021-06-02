//
//  MainProfileFirstVC.swift
//  FinalProject
//
//  Created by Zhaisan on 12.05.2021.
//

import UIKit
import CoreData
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class MainProfileFirstVC: UIViewController, Editable {
    func Edit(_ name: String, _ surname: String) {
        self.ref.child("users/\(Auth.auth().currentUser!.uid)/name").setValue(name)
        self.ref.child("users/\(Auth.auth().currentUser!.uid)/surname").setValue(surname)
        name_label.text = name
        surname_label.text = surname
        
    }
    
    @IBOutlet weak var name_label: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var surname_label: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var current_user: User?
    var name: String?
    var surname: String?
    var myRecipes: [RecipeData] = []
    var recipes: [RecipeData] = []
    
    let ref = Database.database().reference()
    let storageRef = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editProfileButton.layer.cornerRadius = 5
        current_user = Auth.auth().currentUser
        
        self.collectionView.delegate = self
        
        data()
//        recipes = loadRecipes()
        
        let parent = ref.child("recipe")
        parent.observe(.value){[weak self] (snapshot) in
            self?.myRecipes.removeAll()
            for child in snapshot.children{
                if let snap = child as? DataSnapshot{
                    let recipe = RecipeData(snapshot: snap)
                    if recipe.author == self?.current_user?.uid{
                        print("bhjdfzbjvzjdkvzbkjzkja")
                        self?.myRecipes.append(recipe)
                    }
                }
            }
            self?.myRecipes.reverse()
            self?.recipes = self!.myRecipes
            self?.collectionView.reloadData()
        }
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print("sign out error")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func data(){
        ref.child("users").child((current_user?.uid)!).observeSingleEvent(of: .value, with: {[weak self]
            (snapshot) in
            let value = snapshot.value as? NSDictionary
            self?.name = value?["name"] as? String ?? ""
            self?.surname = value?["surname"] as? String ?? ""
            self?.name_label.text = self?.name
            self?.surname_label.text = self?.surname
        }){(error) in
            print(error.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let deg = segue.destination as? EditProfileVC {
                deg.delegate = self
                deg.name = self.name_label.text
                deg.surname = self.surname_label.text
                
        }
    }
    
    
    @IBAction func mySegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            print(myRecipes)
            recipes = myRecipes
        }
        else if sender.selectedSegmentIndex == 1{
            recipes = RecipeDetailVC.likedRecipe
        }
        else if sender.selectedSegmentIndex == 2{
            recipes = RecipeDetailVC.savedRecipe
        }
        self.collectionView.reloadData()
    }
    
//    func loadRecipes()->[RecipeData]{
//        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//            let context = appDelegate.persistentContainer.viewContext
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedRecipe")
//            do {
//                try recipes = context.fetch(fetchRequest) as! [RecipeData]
//            }
//            catch {}
//        }
//        return recipes
//    }
}

extension MainProfileFirstVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! RecipesCollectionCell
        cell.setup(recipe: recipes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        RecipeDetailVC.thisRecipe = recipes[indexPath.row]
        let controller = storyboard?.instantiateViewController(identifier: "ingredientDetail") as! UIViewController
        controller.modalPresentationStyle = .automatic
        controller.modalTransitionStyle = .flipHorizontal
        self.present(controller, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
    
}
