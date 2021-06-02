//
//  ShoppingLIstTVC.swift
//  FinalProject
//
//  Created by Amina Moldamyrza on 5/11/21.
//

import UIKit

class ShoppingLIstTVC: UITableViewController {

    @IBOutlet var myTableView: UITableView!
    
    var products: [RecipeData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        products = RecipeDetailVC.shoppingListRecipes
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let url = URL(string: products[indexPath.row].image)
        let data = try? Data(contentsOf: url!)
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell
        cell.imgView.image = UIImage(data: data!)
        cell.titleLabel.text = products[indexPath.row].title
        cell.subLabel.text = "\(products[indexPath.row].ingredients.count) ingredients missing"
        cell.imgView.layer.cornerRadius = 10
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ShoppingListDetailVC
        let url = URL(string: products[myTableView.indexPathForSelectedRow!.row].image)
        let data = try? Data(contentsOf: url!)
        destination.productList = products[myTableView.indexPathForSelectedRow!.row].ingredients
        destination.productName = products[myTableView.indexPathForSelectedRow!.row].title
        destination.img = UIImage(data: data!)!
    }

}

extension String {
    func localizedShoppingList() -> String{
        return NSLocalizedString(self,
                                 tableName: "ShoppingLIstTVCLocalization",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}
