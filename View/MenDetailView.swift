//
//  MenDetailView.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-31.
//

import SwiftUI

struct MenDetailView: View {
    let mproduct: MenProductModel
    @State private var selectedSize: String = ""
    @State private var quantity: Int = 1
    @StateObject var viewModel = MenDetailViewModel()
    
    var body: some View {
        VStack {
            
            AsyncImage(url: URL(string: mproduct.image)) { phase in
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
            
          
            Text(mproduct.name)
                .font(.title)
            Text(String(format: "$%.2f", mproduct.price))
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

struct MenDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MenDetailView(mproduct: MenProductModel(id: 1, name: "Sample Product", image: "sample", price: 29.99))
    }
}
