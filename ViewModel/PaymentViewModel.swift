//
//  PaymentViewModel.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-31.
//

import Foundation
class PaymentViewModel: ObservableObject {
    @Published var payment: PaymentModel
    
    init(payment: PaymentModel) {
        self.payment = payment
    }
    
    func processPayment() {
        // Implement payment processing logic here
        // This could involve communicating with a payment gateway or other services
        // After processing the payment, you may want to update UI or perform other actions
    }
}
