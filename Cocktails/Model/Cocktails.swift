//
//  Cocktails.swift
//  Cocktails
//
//  Created by Egor Korp on 11.09.22.
//

import Foundation

struct Drink: Decodable {
    let drinks: [Cocktail]
}

struct Cocktail: Decodable, Equatable {
    var strDrink: String
    var strCategory: String?
    var strAlcoholic: String
    var strDrinkThumb: String?
    var strIngredient1: String?
    var strIngredient2: String?
    var strIngredient3: String?
    var strIngredient4: String?
    var strIngredient5: String?
    var strIngredient6: String?
    var strIngredient7: String?
    var strIngredient8: String?
    var strIngredient9: String?
    var strIngredient10: String?
    var strIngredient11: String?
    var strIngredient12: String?
    var strIngredient13: String?
    var strIngredient14: String?
    var strIngredient15: String?
    var strInstructions: String
}
