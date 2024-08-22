//
//  ProductDataListViewModel.swift
//  PTWLiveCodingInterview
//
//  Created by Luiz Araujo on 21/08/24.
//

import Foundation

final class ProductDataListViewModel {
    var products = [ProductElement]()

    private let requestService: RequestServiceProtocol

    private let mainEndpoint = Endpoint.fetch.rawValue

    init(
        requestService: RequestServiceProtocol = RequestService()
    ) {
        self.requestService = requestService

        try? self.updateProducts()
    }

    func updateProducts() throws {
        try requestService.fetch(urlString: mainEndpoint) { prod in
            self.products = prod
        }
    }

    func getSections() -> [String] {
        var result = [String]()

        for category in ProductCategory.allCases {
            result.append(category.rawValue)
        }

        return result
    }
}

extension ProductDataListViewModel {

    /// Formats the price that comes from API and display as string with current currency
    func formatPrice(_ price: Int) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale.current

        // We'll force unwrap with the !, if you've got defined data you may need more error checking

        let priceString = currencyFormatter.string(from: NSNumber(value: price))!
        return priceString
    }
}
