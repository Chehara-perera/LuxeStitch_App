//
//  StartView.swift
//  LuxeStitch
//
//  Created by Chehara Perera on 2024-03-28.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationView{
            VStack{
                Image ("Logo")
            
                HStack{
                    
                    NavigationLink(destination: SignUpView().navigationBarBackButtonHidden(true) ) {
                       
                            Text("Next")
                                .foregroundColor(.black)
                            Image(systemName:"chevron.right")
                            .foregroundColor(.black)

                    }
                }
                
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

