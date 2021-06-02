//
//  SearchVC.swift
//  FinalProject
//
//  Created by Zhaisan on 25.04.2021.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mytableview: UITableView!
    
    var recipes: [RecipeData] = []
    var searchRecipes: [RecipeData] = []
    var searching = false
    
    var ref: DatabaseReference!
    var current_user: User?
    var titleString: String? {
        didSet {
            mytableview.reloadData()
        }
    }
    var subtitleString: String?
    var recipeImage: UIImage?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchRecipes.count
        }
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? CustomCellRecipe
        if searching{
            mytableview.isHidden = false
            cell?.recipeTitle.text = searchRecipes[indexPath.row].title
            cell?.recipeSubtitle.text = searchRecipes[indexPath.row].desc
            let url = URL(string: searchRecipes[indexPath.row].image)
                let data = try? Data(contentsOf: url!)
                if let imageData = data {
                    cell?.imageRecipe.image = UIImage(data: imageData)
            }
        }
        else{
            mytableview.isHidden = true
            cell?.recipeTitle.text = searchRecipes[indexPath.row].title
            cell?.recipeSubtitle.text = searchRecipes[indexPath.row].desc
            let url = URL(string: searchRecipes[indexPath.row].image)
                let data = try? Data(contentsOf: url!)
                if let imageData = data {
                    cell?.imageRecipe.image = UIImage(data: imageData)
                }
            }
        return cell!
    }
    

    
    @IBOutlet weak var search_bar: UISearchBar!
    
    @IBOutlet var cards: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.search_bar.layer.cornerRadius = 4.0
        self.search_bar.clipsToBounds = true
        for card in cards{
            card.layer.cornerRadius = 9
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mytableview.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "fromSearchToDetail", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        mytableview.reloadData()
        current_user = Auth.auth().currentUser
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("recipe").child(userID!).observeSingleEvent(of: .value, with: { [self] (snapshot) in
              // Get user value
        let value = snapshot.value as? NSDictionary
        titleString = value?["title"] as? String ?? ""
        subtitleString = value?["desc"] as? String ?? ""
        recipeImage = value?["image"] as? UIImage
                
        // ...
        }) { (error) in
            print(error.localizedDescription)
        }
            // Do any additional setup after loading the view.
            
        let parent = Database.database().reference().child("recipe")
        parent.observe(.value) { [weak self](snapshot) in
            self?.recipes.removeAll()
            for child in snapshot.children {
                if let snap = child as? DataSnapshot {
                    let recipe = RecipeData(snapshot: snap)
                    print(recipe.title as Any)
                    self?.recipes.append(recipe)
                }
            }
                self?.recipes.reverse()
            self?.searchRecipes = self!.recipes
                self?.mytableview.reloadData()
            }
        mytableview.rowHeight = 100
            
            
        }
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchRecipes.removeAll()
            for recipe in recipes {
                print(searchText.lowercased())
                if recipe.title.lowercased().range(of: searchText.lowercased()) != nil {
                        searchRecipes.append(recipe)
                    }
                }
            searching = true
            if searchText == "" {
                searching = false;
            }
            mytableview.reloadData()
            
        }
    
    
}
