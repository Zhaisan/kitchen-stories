//
//  ProductDetailCell.swift
//  FinalProject
//
//  Created by Amina Moldamyrza on 5/12/21.
//

import UIKit

class ProductDetailCell: UITableViewCell {
    
    var checked: Bool = false
    var vc = ShoppingListDetailVC()

    @IBOutlet weak var check: UIButton!
    @IBOutlet weak var ttlLabel: UILabel!
    
    func settings(){
        check.layer.cornerRadius = 5
        if checked{
            check.setImage(UIImage(named: "check"), for: .normal)
        }else{
            check.setImage(UIImage(), for: .normal)
        }
        vc.TableView?.reloadData()
    }
    
    @IBAction func checkTapped(_ sender: Any) {
        checked = !checked
        settings()
    }
    
}
