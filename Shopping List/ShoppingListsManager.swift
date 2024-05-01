//
//  JsonCoding.swift
//  Shopping List
//
//  Created by Andreas Zikovic on 2024-04-30.
//

import Foundation

struct JsonCoding {
    
    func loadListsFromJson() -> [ShoppingList] {
        var shoppingLists: [ShoppingList] = []
        
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDirectory.appendingPathComponent("shoppingLists.json")
            
            do {
                let jsonData = try Data(contentsOf: fileURL)
                shoppingLists = try JSONDecoder().decode([ShoppingList].self, from: jsonData)
                print("SUCCESS: Shopping lists loaded successfully")
            } catch {
                print("ERROR: Loading shopping list failed \n\(error)")
            }
        }
        
        return shoppingLists
    }
    
    func saveListToJson(list: ShoppingList) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let jsonData = try encoder.encode(list)
            
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentsDirectory.appendingPathComponent("shoppingLists.json")
                
                if FileManager.default.fileExists(atPath: fileURL.path) {
                    if let existingData = try? Data(contentsOf: fileURL) {
                        var existingLists = try JSONDecoder().decode([ShoppingList].self, from: existingData)
                        
                        if let existingIndex = existingLists.firstIndex(where: { $0.id == list.id }) {
                            existingLists[existingIndex] = list
                        } else {
                            existingLists.append(list)
                        }
                        
                        let updateData = try encoder.encode(existingLists)
                        try updateData.write(to: fileURL)
                    } else {
                        try jsonData.write(to: fileURL)
                    }
                } else {
                    try jsonData.write(to: fileURL)
                }
                print("Shopping list saved to \(fileURL)")
            }
        } catch {
            print("ERROR encoding or saving shopping list: \(error)")
        }
    }
}
