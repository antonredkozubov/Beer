//
//  DataModel.swift
//  Beer
//
//  Created by Anton Redkozubov on 08.07.2021.
//

import Foundation

struct DataResponse: Decodable {
    var dataModel: [DataModel]
}

struct DataModel: Decodable {
    var id: Int
    var name: String
    var tagline: String
    var description: String
    var imageUrl: String

    enum CodingKeys: String, CodingKey {
        case id, name, tagline, description
        case imageUrl = "image_url"
    }
}
