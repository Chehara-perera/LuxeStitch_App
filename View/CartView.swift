//
//  CartView.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-23.
//
import SwiftUI

struct CartView: View {
    @StateObject private var viewModel = CartViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.items) { item in
                        CartItemView(item: item, onDelete: { viewModel.deleteItem(item) })
                    }
                }
                Spacer()
                Text("Total Items: \(viewModel.totalItems)")
                    .padding()
                Text("Total Price: $\(String(format:"%.2f", viewModel.totalPrice))")
                    .padding() // Display total price
                Button(action: viewModel.checkout) {
                    Text("Checkout")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationBarItems(
                leading:
                    HStack {
                        Text("Cart")
                            .font(.title)
                            .frame(width: 70, height: 50)
                            .foregroundColor(.green)
                            .padding()
                    },
                trailing:
                    HStack(spacing: 20) {
                        NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true)) {
                            Image(systemName: "house")
                                .imageScale(.large)
                                .foregroundColor(.green)
                        }
                        
                    }
            )
        
            .navigationBarTitle("")
            
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}

import SwiftUI

struct CartItemView: View {
    let item: CartModel
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            Image(item.imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(8)
            VStack(alignment: .leading) {
                Text(item.name)
                Text("Price: $\(String(format: "%.2f", item.price))")
                Text("Quantity: \(item.quantity)")
                    .font(.caption)
            }
            Spacer()
            Button(action: onDelete) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .padding(.vertical, 8)
    }
}
