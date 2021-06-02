//
//  ProfileFirstVC.swift
//  FinalProject
//
//  Created by Zhaisan on 11.05.2021.
//

import UIKit

class ProfileFirstVC: UIViewController {

    
    @IBOutlet weak var sign_inButton: UIButton!
    @IBOutlet weak var sign_upButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sign_inButton.layer.cornerRadius = 5
        sign_upButton.layer.cornerRadius = 5
    }
    

    

}
