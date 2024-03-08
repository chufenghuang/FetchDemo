//
//  ContentView.swift
//  FetchDemo
//
//  Created by 黄先生 on 3/8/24.
//

import SwiftUI

struct ContentView: View {
    // State for storing the loading status
    @State private var isLoading = false
    
    // State for storing the fetched JSON or an error message
    @State private var jsonData: String? = nil
    @State private var errorMessage: String? = nil
    @State private var allItems:[Item] = []
    
    var groupedByListId: [Int: [Item]] {
          Dictionary(grouping: allItems) { $0.listId }
      }
    
    var body: some View {
        
        Group{
            if(isLoading){
                ProgressView("Data is Loading...")
            }else{
                
                List {
                    // Group the items by listId and create a Section for each group
                    ForEach(groupedByListId.keys.sorted(), id: \.self) { listId in
                        Section(header: Text("List ID: \(listId)")) {
                            // For each item in this listId group, create a cell
                            ForEach(groupedByListId[listId] ?? []) { item in
                                ItemCell(item: item)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            loadData()
        }
    }
    
    func loadData(){
        isLoading = true
        
        //The target url we need to get json data from
        let urlString = "https://fetch-hiring.s3.amazonaws.com/hiring.json"
        
        // Fetch JSON data from the given URL
        JsonDataHandler.shared.fetchJSONData(from: urlString) { result in
           switch result {
           //If the JSON data is successfully fetched, update the state with the JSON data
           case .success(let jsonString):
               // Update the state with the fetched JSON data
               self.jsonData = jsonString
               self.errorMessage = nil
               //Decode the JSON string to an array of Item objects, then clean the data and sort them
               let rawItems = JsonDataHandler.shared.decodeItems(from: jsonData ?? "") ?? []
               self.allItems = JsonDataHandler.shared.organizeItems(rawItems)
               isLoading = false
               
           //If there is an error about fetching the JSON data, update the state with the error message
           case .failure(let error):
               // Update the state with the error message
               self.errorMessage = error.localizedDescription
               self.jsonData = nil
           }
        }
    }
}

#Preview {
    ContentView()
}
