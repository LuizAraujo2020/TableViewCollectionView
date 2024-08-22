//
//  NetworkError.swift
//  PTWLiveCoding
//
//  Created by Luiz Araujo on 21/08/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidUrl
    case networkError(Error)
    case decodingError(Error)
    case notFound

    var errorDescription: String? {
        switch self {
        case .invalidUrl: return "Invalid URL, please check it and try again."
        case .networkError: return "A problem with the network has ocurred, please try again."
        case .decodingError: return "An error with the decoding of the JSON."
        case .notFound: return "404/n No products found."
        }
    }
}
