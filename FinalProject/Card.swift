//
//  Card.swift
//  FinalProject
//
//  Created by Amina Moldamyrza on 28.05.2021.
//

import Foundation
import FirebaseDatabase

struct Card {
    var desc : String?
    var id : Int?
    var image : String?
    var recipe : [RecipeData]?
    var dict : [String: Any] {
        return[
            "desc" : desc!,
            "id" : id!,
            "image" : image!
        ]
    }
    
    init(desc: String, image: String) {
        self.desc = desc
        self.image = image
    }
    
    init(snapshot: DataSnapshot){
        if let value = snapshot.value as? [String: Any]{
            desc = value["desc"] as? String
            id = value["id"] as? Int
            image = value["image"] as? String
            recipe = value["recipe"] as? [RecipeData]
        }
    }
}
