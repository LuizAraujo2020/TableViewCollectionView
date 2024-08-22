//
// RequestServiceProtocol.swift
// PTWLiveCoding
//
//  Created by Luiz Araujo on 21/08/24.
//

import Foundation

protocol RequestServiceProtocol {
    func fetch(urlString: String, completion: @escaping ([ProductElement]) -> Void) throws
}
