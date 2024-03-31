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
       
    }
}
