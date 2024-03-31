//
//  ProfileView.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-30.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    let email: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let user = viewModel.user {
                Text("First Name: \(user.firstName)")
                Text("Last Name: \(user.lastName)")
                Text("Email: \(user.email)")
                Text("Telephone: \(user.telephone)")
                Text("Address: \(user.address)")
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            } else {
                ProgressView()
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Profile")
        .onAppear {
            viewModel.fetchUserData(email: email)
        }
    }
}


