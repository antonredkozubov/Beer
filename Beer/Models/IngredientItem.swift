//
//  IngredientItem.swift
//  Beer
//
//  Created by Anton Redkozubov on 17.07.2021.
//

import Foundation

class IngredientItem: Decodable {
    var name: String
    var amount: AmountModel

    enum CodingKeys: String, CodingKey {
        case name
        case amount
    }
}
