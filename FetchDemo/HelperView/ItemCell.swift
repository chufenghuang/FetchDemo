//
//  ItemCell.swift
//  FetchDemo
//
//  Created by 黄先生 on 3/8/24.
//

import SwiftUI

struct ItemCell: View {
    let item:Item
    var body: some View {
         HStack {
             VStack(alignment: .leading, spacing: 4) {
                 Text(item.name ?? "")
                     .font(.headline)
                     .foregroundColor(.primary)
                 Text("List ID: \(item.listId)")
                     .font(.footnote)
                     .foregroundColor(.secondary)
             }

             Spacer()

             VStack(alignment: .trailing, spacing: 4) {
                 HStack(spacing: 2) {
                     Image(systemName: "barcode")
                         .font(.footnote)
                         .foregroundColor(.secondary)
                     Text("ID")
                         .font(.footnote)
                         .foregroundColor(.secondary)
                 }

                 Text("\(item.id)")
                     .font(.title3)
                     .foregroundColor(.primary)
             }
         }
         .padding(.vertical, 8)
         .padding(.horizontal, 4) // You can adjust horizontal padding as per your design preference
     }
}

// Define a preview for your SwiftUI previews
struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of Item with mock data
        let mockItem = Item(id: 681, listId: 4, name: "Item 681")
        
        // Pass the mock Item to ItemCell
        ItemCell(item: mockItem)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
