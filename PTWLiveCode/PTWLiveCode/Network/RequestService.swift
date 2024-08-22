//
// NetworService.swift
// PTWLiveCoding
//
// Created by Luiz Araujo on 21/08/24.
//

import Foundation

final class RequestService: RequestServiceProtocol {

    func fetch(urlString: String, completion: @escaping ([ProductElement]) -> Void) throws {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidUrl
        }

        URLSession.shared.fetchData(for: url) { (result: Result<[ProductElement], Error>) in
            switch result {
            case .success(let products):
                // A list of todos!
                completion(products)
            case .failure(let error):
                print(error)
            }
        }
    }
}
