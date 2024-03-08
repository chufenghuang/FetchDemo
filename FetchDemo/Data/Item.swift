//
//  Item.swift
//  FetchDemo
//
//  Created by Chufeng Huang on 3/8/24.
//

import Foundation

class Item:Codable,Identifiable{
    //Properties
    var id: Int
    var listId: Int
    var name: String?
    
    //Initializer for the Item class
    init(id: Int, listId: Int, name: String?) {
        self.id = id
        self.listId = listId
        self.name = name
    }
}
