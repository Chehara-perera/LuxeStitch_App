//
//  FeedbackView.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-29.
//
import SwiftUI

struct FeedbackView: View {
    @StateObject var viewModel = FeedbackViewModel()
    @State private var feedbackText = ""
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var isMenuOpen = false
    
    let feedbackPlaceholder = "Enter your feedback here..." // Placeholder text
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                                .padding()
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                                .padding()
                                .foregroundColor(.gray)
                        }
                        
                        Button("Choose Image") {
                            isImagePickerPresented = true
                        }
                        .padding()
                        .background(Color.blue.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding()
                        
                        TextEditor(text: $feedbackText)
                            .frame(minHeight: 200)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.primary.opacity(0.2), lineWidth: 1)
                            )
                            .padding(.horizontal)
                            .onTapGesture {
                                if feedbackText == feedbackPlaceholder {
                                    feedbackText = ""
                                }
                            }
                            .foregroundColor(feedbackText == feedbackPlaceholder ? .gray : .primary)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 4)
                            .overlay(
                                Text(feedbackText == "" ? feedbackPlaceholder : "")
                                    .padding(.leading, 5)
                                    .foregroundColor(.gray)
                                    .opacity(feedbackText.isEmpty ? 0.8 : 0)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 4) 
                            )
                        
                        Button("Submit Feedback") {
                            viewModel.submitFeedback(feedbackText: feedbackText, image: selectedImage)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding()
                        
                        if viewModel.showError {
                            Text(viewModel.errorMessage)
                                .foregroundColor(.red)
                                .padding()
                        }
                        
                        Spacer()
                    }
                    
                    if isImagePickerPresented {
                        Color.black.opacity(0.3)
                            .onTapGesture {
                                isImagePickerPresented.toggle()
                            }
                    }
                    
                    if isMenuOpen {
                        Color.black.opacity(0.3)
                            .onTapGesture {
                                withAnimation {
                                    isMenuOpen.toggle()
                                }
                            }
                    }
                    
                    SideMenu(isOpen: $isMenuOpen)
                        .frame(width: geometry.size.width * 0.7)
                        .offset(x: isMenuOpen ? 0 : -geometry.size.width)
                        .animation(.default)
                }
            }
            .navigationBarItems(
                leading:
                    HStack {
                        Image("Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 50)
                            .padding()
                    },
                trailing:
                    HStack(spacing: 20) {
                        NavigationLink(destination: CartView()) {
                            Image(systemName: "cart")
                                .imageScale(.large)
                                .foregroundColor(.green)
                        }
                        
                        Button(action: {
                            withAnimation {
                                isMenuOpen.toggle()
                            }
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .imageScale(.large)
                                .foregroundColor(.green)
                        }
                    }
            )
            .navigationBarTitle("")
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(image: $selectedImage)
            }
        }
        
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}
