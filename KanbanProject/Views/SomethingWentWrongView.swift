//
//  SomethingWentWrongView.swift
//  KanbanProject
//
//  Created by Alex  on 29/9/24.
//

import SwiftUI

struct SomethingWentWrongView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
            
            Text("Something went wrongqwe")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Please restart the app or try again later.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: {
                
            }) {
                Text("Restart App")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .shadow(radius: 10)
    }
}

#Preview {
    SomethingWentWrongView()
}
