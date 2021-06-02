//
//  ShoppingListDetailVC.swift
//  FinalProject
//
//  Created by Amina Moldamyrza on 5/12/21.
//

import UIKit

class ShoppingListDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var productList: [String] = []
    var img = UIImage()
    var productName: String = ""

    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var productImage: UIImageView!
    
    override func viewDidLoad() {
        productImage.image = img
        print(productName)
        self.title = productName
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productNameCell") as! ProductDetailCell
        cell.ttlLabel.text = productList[indexPath.row]
        cell.settings()
        return cell
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

}
