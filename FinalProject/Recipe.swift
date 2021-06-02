//
//  Recipe.swift
//  FinalProject
//
//  Created by Amina Moldamyrza on 5/13/21.
//

import Foundation
import FirebaseDatabase

struct RecipeData {
    var author: String = ""
    var title: String = ""
    var ingredients: [String] = []
    var steps: String = ""
    var portion: String = "1 service"
    var prepTime: String = "0 hours"
    var backingTime: String = "0 hours"
    var restingTime: String = "0 hours"
    var image: String = ""
    var desc: String = ""
    var likes: Int = 0
    var difficulty: String = "Easy"
    var category_id: Int = 1
    var dict : [String: Any] {
        return[
            "author" : author,
            "title" : title,
            "preptime" : prepTime,
            "portion" : portion,
            "ingredients": ingredients,
            "image" : image,
            "likes" : likes,
            "steps" : steps,
            "desc" : desc,
            "difficulty" : difficulty,
            "category_id" : category_id
            
        ]
    }
    
    init(author: String, image: String, title: String, portion: String, prepTime: String, ingredients: [String], steps: String, desc: String, difficulty: String) {
        self.author = author
        self.title = title
        self.portion = portion
        self.prepTime = prepTime
        self.ingredients = ingredients
        self.image = image
        self.steps = steps
        self.desc = desc
        self.difficulty = difficulty
        self.likes = 0
        self.category_id = 1
    }
    
    
    init(snapshot: DataSnapshot){
        if let value = snapshot.value as? [String: Any]{
            author = value["author"] as! String
            title = value["title"]  as! String
            portion = value["portion"] as! String
            steps = value["steps"] as! String
            ingredients = value["ingredients"] as! [String]
            prepTime = value["preptime"] as! String
            image = value["image"] as! String
            likes = value["likes"] as! Int
            desc = value["desc"] as! String
            difficulty = value["difficulty"] as! String
            category_id = value["category_id"] as! Int
        }
    }
    
}
