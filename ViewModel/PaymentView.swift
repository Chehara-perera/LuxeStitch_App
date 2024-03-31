//
//  PaymentView.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-31.
//
import SwiftUI

struct PaymentView: View {
    @ObservedObject var viewModel: PaymentViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(spacing: 20) { // Add spacing between views
                // Payment method selection
                ForEach(PaymentMethod.allCases, id: \.self) { method in
                    HStack {
                        Image(method.logoImageName)
                            .resizable()
                            .frame(width: 50, height: 30)
                        Text(method.rawValue)
                        Spacer()
                        RadioButton(selected: $viewModel.payment.paymentMethod, id: method.rawValue)
                    }
                    .padding()
                }
                
                // Payment form fields with rounded rectangles
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 0.2)
                    .frame(height: 50) // Adjust the height of the RoundedRectangle
                    .padding(.horizontal) // Reduce horizontal padding
                    .overlay(
                        TextField("Card Number", text: $viewModel.payment.cardNumber)
                            .padding(.horizontal)
                    )
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 0.2)
                    .frame(height: 50) // Adjust the height of the RoundedRectangle
                    .padding(.horizontal) // Reduce horizontal padding
                    .overlay(
                        TextField("Expiry Date", text: $viewModel.payment.expiryDate)
                            .padding(.horizontal)
                    )
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 0.2)
                    .frame(height: 50) // Adjust the height of the RoundedRectangle
                    .padding(.horizontal) // Reduce horizontal padding
                    .overlay(
                        TextField("CVV", text: $viewModel.payment.cvv)
                            .padding(.horizontal)
                    )
                
                // Submit button
                Button("Submit Payment") {
                    viewModel.processPayment()
                }
                .padding()
                .background(Color.green) // Set background color to green
                .foregroundColor(.white) // Set text color to white
                .cornerRadius(10) // Add corner radius for rounded corners
            }
            .padding() // Add overall padding to the VStack
            .navigationBarTitle("Payment", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black) // Set color of the chevron icon
                    .imageScale(.large) // Adjust the size of the chevron icon
            })
            
        }
    }
}

// RadioButton component
struct RadioButton: View {
    @Binding var selected: PaymentMethod?
    let id: String
    
    var body: some View {
        Button(action: {
            selected = PaymentMethod(rawValue: id)
        }) {
            if selected?.rawValue == id {
                Image(systemName: "largecircle.fill.circle")
                    .foregroundColor(.blue)
            } else {
                Image(systemName: "circle")
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
    }
}

// Preview for PaymentView
struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        let samplePayment = PaymentModel(paymentMethod: nil, cardNumber: "", expiryDate: "", cvv: "", paymentAmount: 0.0)
        let viewModel = PaymentViewModel(payment: samplePayment)
        return PaymentView(viewModel: viewModel)
    }
}
