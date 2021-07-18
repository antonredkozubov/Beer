//
//  NetworkDataFetcher.swift
//  Beer
//
//  Created by Anton Redkozubov on 08.07.2021.
//

import Foundation

class NetworkDataFetcher {

    let networkService = NetworkService()

    func fetchBeers(urlString: String, response: @escaping ([DataModel]?) -> Void) {
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let beers = try JSONDecoder().decode([DataModel].self, from: data)
                    print(beers.count)
                    response(beers)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
}
