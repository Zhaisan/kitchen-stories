//
//  RegisterVC.swift
//  FinalProject
//
//  Created by Zhaisan on 11.05.2021.
//

import UIKit
import Firebase
import FirebaseAuth


class RegisterVC: UIViewController {

    var ref: DatabaseReference!
    
    @IBOutlet weak var email_TF: UITextField!
    @IBOutlet weak var password_TF: UITextField!
    @IBOutlet weak var sign_upButton: UIButton!
    @IBOutlet weak var name_TF: UITextField!
    @IBOutlet weak var surname_TF: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sign_upButton.layer.cornerRadius = 5
        ref = Database.database().reference()
    }
    
    
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBAction func sign_upPressed(_ sender: UIButton) {
        
        let email = email_TF.text
        let password = password_TF.text
        let name = name_TF.text
        let surname = surname_TF.text
        
        
        
        
        
        
        if email != "" && password != "" && name != "" && surname != ""{
            indicator.startAnimating()
            Auth.auth().createUser(withEmail: email!, password: password!){ [weak self] (result, error) in
                self?.indicator.stopAnimating()
                Auth.auth().currentUser?.sendEmailVerification(completion: nil)
                if error == nil{
                    self?.showMessage(title: "Success", message: "Please verify your email")
                    let userData = ["name": name,
                                    "surname": surname]
                    self!.ref.child("users").child(Auth.auth().currentUser!.uid).setValue(userData)
                }
                else{
                    self?.showMessage(title: "Error", message: "Some problem occured")
                }
            }
        }
    }
    
    func showMessage(title: String, message: String){
        //create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        //add an action (button)
        let ok = UIAlertAction(title: "OK", style: .default){
            (UIAlertAction) in
            if title != "Error"{
                self.dismiss(animated: true, completion: nil)
            }
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    

}
