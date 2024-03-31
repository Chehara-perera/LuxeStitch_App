//
//  HomeView.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-28.
//
import SwiftUI

struct HomeView: View {
    @State private var isMenuOpen = false
    @State private var searchText = ""
    @State private var isSearching = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    ScrollView {
                        VStack {
                            HStack {
                                SearchBar(searchText: $searchText, isSearching: $isSearching)
                                    .padding()
                                
                                Spacer()
                            }
                            
                            VStack(alignment: .leading) {
                                Text("New Arrivals")
                                    .foregroundColor(.black)
                                    .padding()
                                ImageSlider()
                                
                                Text("Categories")
                                    .foregroundColor(.black)
                                    .padding()
                                
                                CategoryGridView()
                                
                                Text("Bestsellers")
                                    .foregroundColor(.black)
                                    .padding()
                                ImageSlider2()
                                
                                Spacer()
                            }
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
                    .navigationTitle("")
                    
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
        }
    }
}

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(.leading, 24)
                .padding(.vertical, 12)
                .padding(.trailing, 8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
                .onTapGesture {
                    isSearching = true
                }
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                        
                        if isSearching {
                            Button(action: {
                                searchText = ""
                                isSearching = false
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
            
            if isSearching {
                Button(action: {
                    searchText = ""
                    isSearching = false
                }) {
                    Text("Cancel")
                        .foregroundColor(.green)
                        .padding(.trailing, 8)
                }
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
        .padding(.top, 8)
        .animation(.default)
    }
}

struct CategoryGridView: View {
    let categories = ["Women", "Men", "Baby"]
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            ForEach(categories, id: \.self) { category in
                CategoryItem(name: category)
            }
        }
        .padding()
    }
}

struct CategoryItem: View {
    let name: String
    
    var body: some View {
        let destinationView: AnyView
        
        switch name {
        case "Women":
            destinationView = AnyView(WomenProductView())
        case "Men":
            destinationView = AnyView(MenProductView())
        case "Baby":
            destinationView = AnyView(KidProductView())
        default:
            destinationView = AnyView(EmptyView())
        }
        
        return NavigationLink(destination: destinationView) {
            Text(name)
                .font(.body)
                .foregroundColor(.black)
                .frame(width: 80, height: 50)
                .padding()
                .background(Color.green.opacity(0.3))
                .cornerRadius(8)
        }
    }
}

struct ImageSlider: View {
    var body: some View {
        TabView {
            Image("Image1")
                .resizable()
                .scaledToFit()
            Image("Image2")
                .resizable()
                .scaledToFit()
            Image("Image")
                .resizable()
                .scaledToFit()
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .frame(height: 200)
        .padding()
    }
}

struct ImageSlider2: View {
    var body: some View {
        TabView {
            Image("new_arrival1")
                .resizable()
                .scaledToFit()
            Image("new_arrival2")
                .resizable()
                .scaledToFit()
            Image("new_arrival3")
                .resizable()
                .scaledToFit()
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .frame(height: 200)
        .padding()
    }
}

struct SideMenu: View {
    @Binding var isOpen: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 50)
            
            NavigationLink(destination: LoginView()) {
                Text("Profile")
                    .foregroundColor(.green)
                    .padding()
            }
            NavigationLink(destination: WomenProductView()) {
                Text("Women's Collection")
                    .foregroundColor(.green)
                    .padding()
            }
            NavigationLink(destination: MenProductView()) {
                Text("Men's Collection")
                    .foregroundColor(.green)
                    .padding()
            }
            NavigationLink(destination: KidProductView()) {
                Text("Kid's Collection")
                    .foregroundColor(.green)
                    .padding()
            }
            NavigationLink(destination: CartView()) {
                Text("Cart")
                    .foregroundColor(.green)
                    .padding()
            }
            NavigationLink(destination: FeedbackView()) {
                Text("Feedback")
                    .foregroundColor(.green)
                    .padding()
            }
            NavigationLink(destination: LoginView()) {
                Text("Logout")
                    .foregroundColor(.green)
                    .padding()
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 50)
        .background(Color.white)
        .offset(x: isOpen ? 0 : -UIScreen.main.bounds.width)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
