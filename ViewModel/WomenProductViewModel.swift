//
//  WomenProductViewModel.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-28.
//
// WomenProductViewModel.swift

import Foundation

class WomenProductViewModel: ObservableObject {
    @Published var products: [WomenProductModel] = []
    
    func fetchData() {
        guard let url = URL(string: "http://localhost:3000/api/women_products") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Failed to fetch data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                self.products = try JSONDecoder().decode([WomenProductModel].self, from: data)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}


