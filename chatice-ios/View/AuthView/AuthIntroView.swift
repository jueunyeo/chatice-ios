//
//  AuthView.swift
//  chatice-ios
//
//  Created by admin on 2/22/22.
//

import SwiftUI
import Firebase

struct AuthIntroView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.white)
                    .ignoresSafeArea()
                
                //Image()
                
                VStack(spacing: 30) {
                    Spacer()
                    NavigationLink(destination: AuthView()) {
                        Text("μμνκΈ°")
                            .font(.title)
                    }
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 50, height: 50)
                }
            }
        }
        .navigationBarHidden(true)
    }
}
