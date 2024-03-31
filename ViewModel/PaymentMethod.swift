//
//  PaymentMethod.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-31.
//

import SwiftUI

// Enum representing different payment methods
enum PaymentMethod: String, CaseIterable {
    case visa = "Visa"
    case mastercard = "MasterCard"
    case paypal = "PayPal"
    case applePay = "Apple Pay"
    
    var logoImageName: String {
        switch self {
        case .visa:
            return "Visa_logo"
        case .mastercard:
            return "mastercard_logo"
        case .paypal:
            return "paypal_logo"
        case .applePay:
            return "apple_logo"
        }
    }
}
