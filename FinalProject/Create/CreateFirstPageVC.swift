//
//  CreateFirstPageVC.swift
//  FinalProject
//
//  Created by Zhaisan on 04.05.2021.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class CreateFirstPageVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    let ref = Database.database().reference()
    let storageRef = Storage.storage().reference()
    var currentUser: User?
    
    var portion: String?
    var time: String?
    var buttonType: UIButton?
    
    var imageURL: String?
    
    var diff: String?
    var ingredients: [String] = []
    
    let portionTypes = ["pieces", "servings"]
    let portionTypesIndex = ["1", "2"]
    
    let type = ["hour", "minute"]
    let hours = ["1", "2", "3","4", "5", "6", "7", "8", "9", "10",
                 "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
                 "21", "22", "23", "24", "25", "26", "27", "28", "29", "30",
                 "31", "32", "33", "34", "35", "36", "37", "38", "39", "40",
                 "41", "42", "43", "44", "45", "46", "47", "48", "49", "50",
                 "51", "52", "53", "54", "55", "56", "57", "58", "59", "60"]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! IngredientCell
        cell.newIngredient.text = ingredients[indexPath.row]
        return cell
    }
    
    
    
    
    @IBOutlet weak var nameOf_recipe_label: UILabel!
    @IBOutlet weak var nameOf_recipe_TF: UITextField!
    
    @IBOutlet weak var addDesc_label: UILabel!
    @IBOutlet weak var addDesc_textview: UITextView!
    
    @IBOutlet weak var addSteps_label: UILabel!
    @IBOutlet weak var addSteps_textview: UITextView!
    
    @IBOutlet weak var addPhotoRecipe_label: UILabel!
    @IBOutlet weak var addPhotoRecipe_button: UIButton!
    @IBOutlet weak var addPhotoRecipe_image: UIImageView!
    
    @IBOutlet weak var portionType_label: UILabel!
    @IBOutlet weak var portionType_digit_btn: UIButton!
    @IBOutlet weak var portionType_pickerview: UIPickerView!
    @IBOutlet weak var portionType_type_btn: UIButton!
    
    @IBOutlet weak var easy_btn: UIButton!
    @IBOutlet weak var medium_btn: UIButton!
    @IBOutlet weak var hard_btn: UIButton!
    
    @IBOutlet weak var bakingTime_digit_btn: UIButton!
    @IBOutlet weak var bakingTime_type_btn: UIButton!
    @IBOutlet weak var bakingTime_pickerview: UIPickerView!
    
    @IBOutlet weak var addIngredient_TF: UITextField!
    @IBOutlet weak var addIngredient_btn: UIButton!
    
    //@IBOutlet weak var steps_textview: UITextView!
    
    @IBOutlet weak var save_btn: UIButton!
    
    
    
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    @IBAction func portionPressed(_ sender: UIButton) {
        buttonType = portionType_type_btn
        if portionType_pickerview.isHidden{
            portionType_pickerview.isHidden = false
        }
    }
    
  
    @IBAction func bakingPressed(_ sender: UIButton) {
        buttonType = bakingTime_type_btn
        if bakingTime_pickerview.isHidden{
            bakingTime_pickerview.isHidden = false
        }
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
            return 2
        }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
            switch pickerView.tag {
            case 1:
                if component == 0{
                    return portionTypesIndex.count
                }
                else{
                    return portionTypes.count
                }
            case 2:
                if component == 0{
                    return hours.count
                }
                else{
                    return type.count
                }
            default:
                return 1
            }
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

            switch pickerView.tag {
            case 1:
                if component == 0{
                    return portionTypesIndex[row]
                }
                else{
                    return portionTypes[row]
                }
            case 2:
                if component == 0{
                    return hours[row]
                }
                else{
                    return type[row]
                }
            default:
                return "Data not found"
            }
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            switch pickerView.tag {
            case 1:
                if component == 0{
                    portionType_digit_btn.setTitle(portionTypesIndex[row], for: .normal)
                }
                else{
                    portionType_type_btn.setTitle(portionTypes[row], for: .normal)
                    portionType_pickerview.isHidden = true
                }
                portion = "\(portionTypesIndex[row]) \(portionTypes[row])"
            case 2:
                if component == 0{
                    switch buttonType {
                    case bakingTime_type_btn:
                        bakingTime_digit_btn.setTitle(hours[row], for: .normal)
                    default:
                        bakingTime_type_btn.setTitle(hours[row], for: .normal)
                    }
                }else{
                    switch buttonType {
                    case bakingTime_type_btn:
                        bakingTime_type_btn.setTitle(type[row], for: .normal)
                        bakingTime_pickerview.isHidden = true
                    default:
                        bakingTime_type_btn.setTitle(type[row], for: .normal)
                    }
                    time = "\(hours[row]) \(type[row])"
                }
            default:
                break
            }
        }
    
    @IBAction func addImage(_ sender: UIButton) {
        let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                picker.allowsEditing = true
                present(picker, animated: true)
            }
            
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                if let img = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
                    self.addPhotoRecipe_image.image = img
                    guard let imageData = img.pngData() else {return}
                    storageRef.child("images/\(self.currentUser!.uid).png").putData(imageData,
                                                                                    metadata: nil,
                                                                                    completion: { _, error in
                                                                                    guard error == nil
                                                                                    else{
                                                                                        print("Failed")
                                                                                        return
                                                                                    }
                    })
                    
                    self.storageRef.child("images/\(self.currentUser!.uid).png").downloadURL(completion:
                                                                                                { [self]url, error in
                    guard let url = url, error == nil else{ return }
                    let urlString = url.absoluteString
                    imageURL = url.absoluteString

                    UserDefaults.standard.set(urlString, forKey: "imageURL")
                })
                picker.dismiss(animated: true, completion: nil)
                    
            }
        }
            
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
            
    }
    
    @IBAction func easyPressed(_ sender: Any) {
        diff = easy_btn.titleLabel?.text
        easy_btn.layer.borderColor = CGColor.init(red: 128, green: 0, blue: 128, alpha: 1)
    }
        
    @IBAction func mediumPressed(_ sender: Any) {
        diff = medium_btn.titleLabel?.text
        medium_btn.layer.borderColor = CGColor.init(red: 128, green: 0, blue: 128, alpha: 1)
    }
        
    @IBAction func hardPressed(_ sender: Any) {
            diff = hard_btn.titleLabel?.text
            hard_btn.layer.borderColor = CGColor.init(red: 128, green: 0, blue: 128, alpha: 1)
        }
    
    @IBAction func addButtonPressed(_ sender: Any) {
            ingredients.append(addIngredient_TF.text!)
            addIngredient_TF.text = ""
            ingredientsTableView.reloadData()
    }
    
    

    @IBAction func savePressed(_ sender: UIButton) {
        let url = "https://www.eatwell101.com/wp-content/uploads/2019/04/chicken-bites-and-asparagus-recipe.jpg"
        let recipe = RecipeData(author: currentUser!.uid,
//                                image: imageURL!,
                                image: url,
                                title: nameOf_recipe_TF.text!,
                                portion: portion!,
                                prepTime: time!,
                                ingredients: ingredients,
                                steps: addSteps_textview.text!,
                                desc: addDesc_textview.text!,
                                difficulty: diff!)
        ref.child("recipe").childByAutoId().setValue(recipe.dict)
        addIngredient_TF.text = ""
        nameOf_recipe_TF.text = ""
        addPhotoRecipe_image.image = nil
        ingredients = []
        ingredientsTableView.reloadData()
        placeholder()
        bakingTime_type_btn.setTitle("type", for: .normal)
        bakingTime_digit_btn.setTitle("0", for: .normal)
        portionType_type_btn.setTitle("type", for: .normal)
        portionType_digit_btn.setTitle("0", for: .normal)
        portionType_pickerview.isHidden = true
        bakingTime_pickerview.isHidden = true
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func placeholder(){
        addDesc_textview.text = "Please, add some description about recipe"
        addDesc_textview.textColor = UIColor.lightGray
        addSteps_textview.textColor = UIColor.lightGray
        addSteps_textview.text = "Please, add steps"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeholder()
        currentUser = Auth.auth().currentUser
        portionType_pickerview.isHidden = true
        portionType_pickerview.delegate = self
        portionType_pickerview.dataSource = self
        addDesc_textview.delegate = self
        addSteps_textview.delegate = self
                
        bakingTime_pickerview.isHidden = true
        bakingTime_pickerview.delegate = self
        bakingTime_pickerview.dataSource = self
        
        portionType_pickerview.tag = 1
        bakingTime_pickerview.tag = 2
        
        super.viewDidLoad()
        
        easy_btn.layer.cornerRadius = 3
        medium_btn.layer.cornerRadius = 3
        hard_btn.layer.cornerRadius = 3
        addIngredient_TF.borderStyle = .none
        addIngredient_TF.attributedPlaceholder = NSAttributedString.init(string:"Add ingredient, e.g. flour", attributes: [ NSAttributedString.Key.foregroundColor:UIColor.darkGray, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20)])
        
        addIngredient_btn.layer.cornerRadius = 5
        save_btn.layer.cornerRadius = 5
    }
    
    
    

}
