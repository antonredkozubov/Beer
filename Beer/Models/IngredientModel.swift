//
//  IngredientModel.swift
//  Beer
//
//  Created by Anton Redkozubov on 17.07.2021.
//

import Foundation

class IngredientModel: Decodable {
    var malt: [IngredientItem]
    var hops: [IngredientItem]

    enum CodingKeys: String, CodingKey {
        case malt
        case hops
    }
}
