//
//  WomenProductModel.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-28.
//
// WomenProductModel.swift

import Foundation

struct WomenProductModel: Identifiable, Decodable {
    let id: Int
    let name: String
    let image: String
    let price: Double
}

