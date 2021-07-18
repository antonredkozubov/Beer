//
//  DataModel.swift
//  Beer
//
//  Created by Anton Redkozubov on 08.07.2021.
//

import Foundation

class DataModel: Decodable {
    var id: Int
    var name: String
    var tagline: String
    var description: String
    var imageUrl: String
    var ingredients: IngredientModel
    var foodPairing: [String]

    enum CodingKeys: String, CodingKey {
        case id, name, tagline, description
        case ingredients
        case imageUrl = "image_url"
        case foodPairing = "food_pairing"
    }
}
