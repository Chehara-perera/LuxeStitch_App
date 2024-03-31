//
//  WomenProductView.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-28.
//
// WomenProductView.swift
import SwiftUI

struct WomenProductView: View {
    @ObservedObject var viewModel = WomenProductViewModel()
    @State private var isMenuOpen = false
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.products.isEmpty {
                    ProgressView()
                } else {
                    List(viewModel.products) { product in
                        NavigationLink(destination: DetailView(product: product)) {
                            WomenProductRowView(product: product)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchData()
            }
            .navigationBarItems(
                leading:
                    HStack {
                        Text("Women's Collection")
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

struct WomenProductRowView: View {
    let product: WomenProductModel
    
    var body: some View {
        HStack {
           
            AsyncImage(url: URL(string: product.image)) { phase in
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
                Text(product.name)
                    .font(.headline)
                Text(String(format: "$%.2f", product.price))
                    .font(.headline)
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            
        }.padding()
    }
}

struct WomenProductView_Previews: PreviewProvider {
    static var previews: some View {
        WomenProductView()
    }
}
