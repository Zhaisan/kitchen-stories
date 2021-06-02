//
//  SignINVC.swift
//  FinalProject
//
//  Created by Zhaisan on 12.05.2021.
//

import UIKit
import Firebase
import FirebaseAuth

class SignINVC: UIViewController {

    
    @IBOutlet weak var email_TF: UITextField!
    @IBOutlet weak var password_TF: UITextField!
    @IBOutlet weak var sign_inButton: UIButton!
    
    var current_user : User?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        current_user = Auth.auth().currentUser
        
         sign_inButton.layer.cornerRadius = 5
    }
    
    override func viewDidAppear(_ animated: Bool) {
            current_user = Auth.auth().currentUser
            if (current_user != nil && current_user!.isEmailVerified) {
                gotoMainPage()
            }
        }
    
    
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBAction func sign_inPressed(_ sender: UIButton) {
        
        let email = email_TF.text
        let password = password_TF.text
        indicator.startAnimating()
        if email != "" && password != ""{
            Auth.auth().signIn(withEmail: email!, password: password!) {
                [weak self] (result, error) in
                self?.indicator.stopAnimating()
                if error == nil{
                    if Auth.auth().currentUser!.isEmailVerified{
                        self?.gotoMainPage()
                    }else{
                        self?.showMessage(title: "Warning", message: "Your email is not verified")
                    }
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
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    func gotoMainPage(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let mainPage = storyboard.instantiateViewController(identifier: "HomeNC") as? UITabBarController{
            mainPage.modalPresentationStyle = .fullScreen
            present(mainPage, animated: true, completion: nil)
        }
    }
    

    

}
