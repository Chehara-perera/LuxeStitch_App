//
//  CartModel.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-29.
//
import Foundation
import SwiftUI

// Model for an item in the cart
struct CartModel: Identifiable {
    let id = UUID()
    let name: String
    let quantity: Int
    let imageName: String
    let price: Double // Price per item
}
