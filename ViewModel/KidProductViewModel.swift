//
//  KidProductViewModel.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-30.
//

import Foundation

class KidProductViewModel: ObservableObject {
    @Published var products: [KidProductModel] = []
    
    func fetchData() {
        guard let url = URL(string: "http://localhost:3000/api/kid_products") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Failed to fetch data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                self.products = try JSONDecoder().decode([KidProductModel].self, from: data)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}
