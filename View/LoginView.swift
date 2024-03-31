//
//  LoginView.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-19.
//
import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding()
                
                VStack(spacing: 20) {
                    TextField("Username", text: $viewModel.username)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    
                    HStack {
                        Spacer()
                        Button("Forgot Password", action: {}) // Action for forgot password
                    }
                    .padding(.top, 8)
                    
                    Button("Submit", action: { viewModel.verifyLogin() })
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    
                    if viewModel.showError {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 100)
                            .padding(40)
                            .foregroundColor(.white)
                            .shadow(radius: 10)
                            .overlay {
                                Text(viewModel.errorMessage)
                                    .lineLimit(3)
                                    .bold()
                                    .foregroundColor(.black)
                                    .padding(48)
                            }
                    }
                }
                .padding()
                .navigationBarTitle("", displayMode: .inline)
              
                NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true), isActive: $viewModel.success) {
                    EmptyView()
                }
                
                HStack {
                    Text("Don't have an account?")
                    NavigationLink(destination: SignUpView().navigationBarBackButtonHidden(true)) {
                        Text("Sign Up")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
