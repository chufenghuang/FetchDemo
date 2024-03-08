//
//  JsonDataHandler.swift
//  FetchDemo
//
//  Created by Chufeng Huang on 3/8/24.
//

import Foundation

class JsonDataHandler{
    static let shared = JsonDataHandler()//Singleton design pattern
    
    private init() {}//To revent others from using the default '()' initializer for this class.
    
    //The function that fetch JSON data from a given URL
    func fetchJSONData(from urlString: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        //Check if the URL is valid.
        guard let url = URL(string: urlString) else {
            //If the URL is invalid, return an error message.
            completion(.failure(NSError(domain: "JsonDataHandler", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL. Please double check the URL and try again."])))
            return
        }
        
        //Fetch data from the URL
        URLSession.shared.dataTask(with: url) { data, response, error in
            //Get the data and check if there is an error
            guard let data = data, error == nil else {
                //If there is an error about the data, return the error message.
                completion(.failure(error ?? NSError(domain: "JsonDataHandler", code: 2, userInfo: [NSLocalizedDescriptionKey: "Error fetching data"])))
                return
            }
            
            //Convert the data to a JSON string
            if let jsonString = String(data: data, encoding: .utf8) {
                //If the data is successfully converted to a JSON string, return the JSON string.
                DispatchQueue.main.async {
                    completion(.success(jsonString))
                }
            } else {
                //If the data cannot be converted to a JSON string, return an error message.
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "JsonDataHandler", code: 3, userInfo: [NSLocalizedDescriptionKey: "Unable to convert data to JSON string"])))
                }
            }
        }.resume()//Start the data task
    }
    
    //The function that decodes the JSON string to an array of Item objects
    func decodeItems(from jsonString: String) -> [Item]? {
        let jsonData = Data(jsonString.utf8)//Convert the JSON string to Data type
        let decoder = JSONDecoder()//Create a JSON decoder instance
        
        //Decode the JSON data to an array of Item objects
        do {
            //Try to decode the JSON data
            let items = try decoder.decode([Item].self, from: jsonData)
            return items
        } catch {
            //If there is an error, print the error message and return nil
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
    
    //The function that organizes the items by listId and name
    func organizeItems(_ items: [Item]) -> [Item] {
        // Filter out items where the name is nil or empty
        let filteredItems = items.filter { item in
            guard let name = item.name, !name.isEmpty else { return false }
            return true
        }

        // Sort the remaining items first by listId, then by the numerical value in the name
            let sortedItems = filteredItems.sorted {
                if $0.listId != $1.listId {
                    return $0.listId < $1.listId
                } else {
                    // Extract the integer values from the item names within the sort closure
                    let num1 = $0.name?.components(separatedBy: CharacterSet.decimalDigits.inverted)
                        .compactMap { substring in Int(substring) }
                        .first ?? Int.max
                    
                    let num2 = $1.name?.components(separatedBy: CharacterSet.decimalDigits.inverted)
                        .compactMap { substring in Int(substring) }
                        .first ?? Int.max
                    
                    return num1 < num2
                }
            }
        
        return sortedItems
    }
}


