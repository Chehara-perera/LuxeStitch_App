//
//  SignUpViewModel.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-28.
//
import Foundation

class SignUpViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var phoneNumber: String = ""
    @Published var address: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var success: Bool = false
    
    func verifySignUp() {
        guard let url = URL(string: "http://localhost:3000/api/users/register") else {
            showError = true
            errorMessage = "Invalid API URL"
            return
        }
        
        guard password == confirmPassword else {
            showError = true
            errorMessage = "Passwords do not match"
            return
        }
        
        let body: [String: Any] = [
            "firstname": firstName,
            "lastname": lastName,
            "email": email,
            "telephone": phoneNumber,
            "address": address,
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
