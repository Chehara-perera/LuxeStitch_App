//
//  FeedbackViewModel.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-29.
//

import Foundation
import UIKit

class FeedbackViewModel: ObservableObject {
    @Published var showError = false
    @Published var errorMessage = ""
    
    func submitFeedback(feedbackText: String, image: UIImage?) {
        
        guard let url = URL(string: "http://localhost:3000/api/feedback") else {
            showError = true
            errorMessage = "Invalid API URL"
            return
        }
        
        // Convert UIImage to Data if an image is selected
        var imageData: Data?
        if let image = image {
            imageData = image.jpegData(compressionQuality: 0.5)
        }
        
        let body: [String: Any] = [
            "feedbackText": feedbackText,
            "imageData": imageData ?? Data()
            
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
            
            
        }.resume()
    }
}
