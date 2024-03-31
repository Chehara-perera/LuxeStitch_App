//
//  ProfileViewModel.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-30.
//
import Foundation

class ProfileViewModel: ObservableObject {
    @Published var user: ProfileModel?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchUserData(email: String) {
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          
            guard let url = URL(string: "http://localhost:3000/api/users/:email") else {
                self.isLoading = false
                self.errorMessage = "Invalid URL"
                return
            }
            
            self.isLoading = true
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    self.isLoading = false
                    
                    guard let data = data, error == nil else {
                        self.errorMessage = error?.localizedDescription ?? "Unknown error"
                        return
                    }
                    
                    do {
                        self.user = try JSONDecoder().decode(ProfileModel.self, from: data)
                    } catch {
                        self.errorMessage = "Failed to decode user data: \(error.localizedDescription)"
                    }
                }
            }.resume()
        }
    }
}
