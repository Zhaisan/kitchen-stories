//
//  EditProfileVC.swift
//  FinalProject
//
//  Created by Zhaisan on 13.05.2021.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

protocol Editable{
    func Edit(_ name: String, _ surname: String)
}

class EditProfileVC: UIViewController {

    var ref: DatabaseReference!
    var current_user: User?
    var name: String?
    var surname: String?
    var delegate: Editable?
    
    @IBOutlet weak var uploadPictureButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBOutlet weak var name_TF: UITextField!
    @IBOutlet weak var surname_TF: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uploadPictureButton.layer.cornerRadius = 5
        saveButton.layer.cornerRadius = 5
        
        name_TF.text = name
        surname_TF.text = surname

    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        delegate?.Edit(name_TF.text!, surname_TF.text!)
        self.dismiss(animated: true, completion: nil)
    }
    
}
