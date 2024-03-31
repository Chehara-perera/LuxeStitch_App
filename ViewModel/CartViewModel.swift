//
//  CartViewModel.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-29.
//
import Foundation
class CartViewModel: ObservableObject {
    @Published var items: [CartModel] = [
        CartModel(name: "Crop top", quantity: 1, imageName: "cart_item1", price: 20.0),
        CartModel(name: "Denim Trouser", quantity: 2, imageName: "cart_item2", price: 40.0),
        CartModel(name: "Floral Print Dress", quantity: 1, imageName: "cart_item3", price: 35.0)
    ]
    
    var totalItems: Int {
        items.map(\.quantity).reduce(0, +)
    }
    
    var totalPrice: Double {
        items.map { $0.price * Double($0.quantity) }.reduce(0, +)
    }
    
    func deleteItem(_ item: CartModel) {
        items.removeAll { $0.id == item.id }
    }
    
    func checkout() {
        // Implement checkout functionality here
    }
}
