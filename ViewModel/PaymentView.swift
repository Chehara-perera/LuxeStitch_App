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
            VStack(spacing: 20) {
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
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 0.2)
                    .frame(height: 50)
                    .padding(.horizontal)
                    .overlay(
                        TextField("Card Number", text: $viewModel.payment.cardNumber)
                            .padding(.horizontal)
                    )
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 0.2)
                    .frame(height: 50)
                    .padding(.horizontal)
                    .overlay(
                        TextField("Expiry Date", text: $viewModel.payment.expiryDate)
                            .padding(.horizontal)
                    )
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 0.2)
                    .frame(height: 50)
                    .padding(.horizontal)
                    .overlay(
                        TextField("CVV", text: $viewModel.payment.cvv)
                            .padding(.horizontal)
                    )
                
               
                Button("Submit Payment") {
                    viewModel.processPayment()
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            .navigationBarTitle("Payment", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .imageScale(.large)
            })
            
        }
    }
}


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


struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        let samplePayment = PaymentModel(paymentMethod: nil, cardNumber: "", expiryDate: "", cvv: "", paymentAmount: 0.0)
        let viewModel = PaymentViewModel(payment: samplePayment)
        return PaymentView(viewModel: viewModel)
    }
}
