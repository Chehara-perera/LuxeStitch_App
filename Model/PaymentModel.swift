//
//  PaymentModel.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-31.
//

import Foundation

struct PaymentModel {
    var paymentMethod: PaymentMethod?
    var cardNumber: String
    var expiryDate: String
    var cvv: String
    var paymentAmount: Double
    // Add more payment details as needed
}
