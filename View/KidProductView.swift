//
//  KidProductView.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-30.
//

import SwiftUI

struct KidProductView: View {
    @ObservedObject var kviewModel = KidProductViewModel()
    @State private var isMenuOpen = false
    
    var body: some View {
        NavigationView {
            VStack {
                if kviewModel.products.isEmpty {
                    ProgressView()
                } else {
                    List(kviewModel.products) { product in
                        NavigationLink(destination: KidDetailView(kproduct: product)) {
                            KidProductRowView(kproduct: product)
                        }
                    }
                }
            }
            .onAppear {
                kviewModel.fetchData()
            }
            .navigationBarItems(
                leading:
                    HStack {
                        Text("Kid's Collection")
                            .frame(width: 200, height: 50)
                            .foregroundColor(.green)
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
            .overlay(
               
                ZStack {
                    if isMenuOpen {
                        Color.black.opacity(0.3)
                            .onTapGesture {
                                withAnimation {
                                    isMenuOpen.toggle()
                                }
                            }
                        
                        SideMenu(isOpen: $isMenuOpen)
                            .frame(width: 250)
                            .background(Color.white)
                            .offset(x: isMenuOpen ? 0 : -250)
                            .animation(.default)
                            .onTapGesture {
                                
                                print("Menu option tapped")
                            }
                    }
                }
            )
        }
    }
}

struct KidProductRowView: View {
    let kproduct: KidProductModel
    
    var body: some View {
        HStack {
            
            AsyncImage(url: URL(string: kproduct.image)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                } else if phase.error != nil {
                    
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                } else {
                    ProgressView() 
                        .frame(width: 100, height: 100)
                }
            }
            
            VStack(alignment: .leading) {
                Text(kproduct.name)
                    .font(.headline)
                Text(String(format: "$%.2f", kproduct.price))
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            
            Spacer()
            
            
        }.padding()
    }
}

struct KidProductView_Previews: PreviewProvider {
    static var previews: some View {
        KidProductView()
    }
}
