//
//  Url.swift
//  Beer
//
//  Created by Anton Redkozubov on 17.07.2021.
//

import Foundation

class Url {
    static let host = "https://api.punkapi.com"
    static func beers(page: Int, perPage: Int) -> String {
        return host + "/v2/beers?page=\(page)&per_page=\(perPage)"
    }
}
