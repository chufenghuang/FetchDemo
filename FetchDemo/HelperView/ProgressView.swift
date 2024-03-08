//
//  ProgressView.swift
//  FetchDemo
//
//  Created by 黄先生 on 3/8/24.
//

import SwiftUI

struct ProgressView: View {
    var body: some View {
        VStack {
             // The default ProgressView will display a spinning indicator
             ProgressView()
                 .progressViewStyle(CircularProgressViewStyle())
                 .scaleEffect(1.5) // Scale effect to make the spinner larger
                 .padding()

             // You can also add a text label to your ProgressView
             ProgressView("Loading...")
                 .padding()
         }
    }
}

#Preview {
    ProgressView()
}
