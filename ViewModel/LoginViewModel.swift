//
//  LoginViewModel.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-25.
//
import Foundation

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var success: Bool = false
    
    func verifyLogin() {
        guard let url = URL(string: "http://localhost:3000/api/users/login") else {
            showError = true
            errorMessage = "Invalid API URL"
            return
        }
        
        let body: [String: Any] = [
            "Email": username,
            "password": password
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.showError = true
                    self.errorMessage = "Error: \(error?.localizedDescription ?? "Unknown error")"
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    DispatchQueue.main.async {
                        self.success = true
                    }
                } else if httpResponse.statusCode == 401 {
                    DispatchQueue.main.async {
                        self.showError = true
                        self.errorMessage = "Invalid credentials"
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showError = true
                        self.errorMessage = "Error: \(httpResponse.statusCode)"
                    }
                }
            }
        }.resume()
    }
}
