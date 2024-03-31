//
//  SignUpView.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-23.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var signVM : SignUpViewModel = SignUpViewModel()
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var address = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .padding()
                
                VStack(spacing: 10) {
                    TextField("First Name", text: $signVM.firstName)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    
                    TextField("Last Name", text: $signVM.lastName)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    
                    TextField("Email", text: $signVM.email)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .keyboardType(.emailAddress)
                
                    TextField("Phone Number", text: $signVM.phoneNumber)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .keyboardType(.phonePad)
                    
                    TextField("Address", text: $signVM.address)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .keyboardType(.phonePad)
                    
                    SecureField("Password", text: $signVM.password)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                       
                    
                    SecureField("Confirm Password", text: $signVM.confirmPassword)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    
                
                        Button("Submit", action: {signVM.verifySignUp()}) // Action for submit
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        
                    if(signVM.showError){
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 100).padding(40)
                            .foregroundColor(.white)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .overlay{
                                Text(signVM.errorMessage)
                                    .lineLimit(3)
                                    .bold().foregroundStyle(.black)
                                    .padding(48)
                            }
                    }
                    NavigationLink("",isActive: $signVM.success){
                        LoginView()
                        
                                    Spacer()
                    
                    }
                   
                    HStack{
                        
                        Text("Already have an account?")
                        NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true)) {
                            Text("Login")
                                .foregroundColor(.blue)
                            
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}



struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
