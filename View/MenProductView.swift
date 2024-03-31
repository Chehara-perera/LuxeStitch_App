//
//  MenProductView.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-28.
//
import SwiftUI

struct MenProductView: View {
    @ObservedObject var mviewModel = MenProductViewModel()
    @State private var isMenuOpen = false
    
    var body: some View {
        NavigationView {
            VStack {
                if mviewModel.products.isEmpty {
                    ProgressView()
                } else {
                    List(mviewModel.products) { product in
                        NavigationLink(destination: MenDetailView(mproduct: product)) {
                            MenProductRowView(mproduct: product)
                        }
                    }
                }
            }
            .onAppear {
                mviewModel.fetchData()
            }
            .navigationBarItems(
                leading:
                    HStack {
                        Text("Men's Collection")
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

struct MenProductRowView: View {
    let mproduct: MenProductModel
    
    var body: some View {
        HStack {
           
            AsyncImage(url: URL(string: mproduct.image)) { phase in
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
                Text(mproduct.name)
                    .font(.headline)
                Text(String(format: "$%.2f", mproduct.price))
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            
            Spacer()
            
            
        }.padding()
    }
}

struct MenProductView_Previews: PreviewProvider {
    static var previews: some View {
        MenProductView()
    }
}
