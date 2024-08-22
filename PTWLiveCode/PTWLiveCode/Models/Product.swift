//
//  Response.swift
//  PTWLiveCoding
//
//  Created by Luiz Araujo on 21/08/24.
//

import Foundation

// MARK: - ProductElement
struct ProductElement: Codable {
    let id: Int
    let productCategory: ProductCategory
    let name: String
    let brand: Brand
    let description: String
    let basePrice: Int
    let inStock: Bool
    let stock: Int
    let featuredImage, thumbnailImage: String
    let storageOptions, colorOptions: [String]
    let display, cpu: String
    let camera: Camera?
    let gpu: String?

    enum CodingKeys: String, CodingKey {
        case id, productCategory, name, brand, description, basePrice, inStock, stock, featuredImage, thumbnailImage, storageOptions, colorOptions, display
        case cpu = "CPU"
        case camera
        case gpu = "GPU"
    }
}

enum Brand: String, Codable {
    case apple = "Apple"
    case lenovo = "Lenovo"
    case samsung = "Samsung"
}

// MARK: - Camera
struct Camera: Codable {
    let rearCamera, frontCamera: String
}

enum ProductCategory: String, Codable, CaseIterable, Equatable {
    case laptop = "Laptop"
    case smartphone = "Smartphone"
    case tablet = "Tablet"
}

typealias Product = [ProductElement]
