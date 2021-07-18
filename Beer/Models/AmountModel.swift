//
//  AmountModel.swift
//  Beer
//
//  Created by Anton Redkozubov on 17.07.2021.
//

import Foundation

class AmountModel: Decodable {
    var value: Double
    var unit: String

    enum CodingKeys: String, CodingKey {
        case value
        case unit
    }
}
