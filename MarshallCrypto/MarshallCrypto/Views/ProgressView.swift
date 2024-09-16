//
//  ProgressView.swift
//  MarshallCrypto
//
//  Created by David Geijer on 2024-09-16.
//

import SwiftUI

struct ProgressView: View {
    
    @State private var isAnimating = false
       
       var body: some View {
           VStack {
             
               Image(systemName: "hourglass.circle")
                   .resizable()
                   .scaledToFit()
                   .frame(width: 80, height: 80)
                   .foregroundColor(.blue)
                   .rotationEffect(.degrees(isAnimating ? 2300 : 0))
                   .animation(.linear(duration: 5.0), value: isAnimating)
                   .padding(.bottom, 50)
                   .shadow(color: .black, radius: 10, x: 0, y: 8)
               
               Text("Loading data... stand by.")
                   .appFontSemiBold16()
                   .foregroundStyle(.appText)
                   .padding()
               
           }.task {
               isAnimating = true
           }
           
       }
    
}



#Preview {
    ProgressView()
}
