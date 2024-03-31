//
//  MenProductModel.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-30.
//

import Foundation

struct MenProductModel: Identifiable, Decodable {
    let id: Int
    let name: String
    let image: String
    let price: Double
}

