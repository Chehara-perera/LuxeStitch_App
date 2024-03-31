//
//  DetailView.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-29.
//

import SwiftUI

struct DetailView: View {
    let product: WomenProductModel
    @State private var selectedSize: String = ""
    @State private var quantity: Int = 1
    @StateObject var viewModel = DetailViewModel()
    
    var body: some View {
        VStack {
            
            AsyncImage(url: URL(string: product.image)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .failure(_):
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .empty:
                    ProgressView()
                @unknown default:
                    EmptyView()
                }
            }
            .frame(height: 300)
            Text(product.name)
                .font(.title)
            Text(String(format: "$%.2f", product.price))
                .font(.headline)
                .foregroundColor(.green)
            
            
            Picker("Select Size", selection: $selectedSize) {
                ForEach(["S", "M", "L", "XL"], id: \.self) { size in
                    Text(size)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
           
            Stepper(value: $quantity, in: 1...10) {
                Text("Quantity: \(quantity)")
            }
            .padding()
            
           
            Button("Add to Cart") {
                // Handle adding to cart
                
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(8)
        }
        .padding()
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(product: WomenProductModel(id: 1, name: "Sample Product", image: "sample", price: 29.99))
    }
}
