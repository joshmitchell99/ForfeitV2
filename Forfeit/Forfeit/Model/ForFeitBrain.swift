//
//  ForFeitBrain.swift
//  Forfeit
//
//  Created by Josh Mitchell on 9/22/20.
//  Copyright © 2020 Edward Raven. All rights reserved.
//

import Foundation

struct ForfeitBrain {
    
    // Create a new array of item objects created from the item class
    var itemArray = [Item]()
    
    // Create a variable to hold the data URL of the filepath for the plist that contains the data to be saved
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    
    mutating func addForfeit(title: String, date: String, amount: Int) {
        
        print("Adding this to The Brain: ", title, date, amount)
        
        let newItem = Item()
        newItem.title = title
        newItem.date = date
        newItem.amount = amount
        //self.itemArray.append(newItem)
        
        
        
        self.saveItem(item: newItem)
        let forfeitListController = ForfeitListController()
        forfeitListController.viewDidLoad()
    }
    
    mutating func saveItem(item: Item) {
        print("Saving items")
        let encoder = PropertyListEncoder()
        
        self.itemArray.append(item)
        
        do {
            let data = try encoder.encode(self.itemArray)
            print("This is the data size", data)
            try data.write(to: dataFilePath!) // Think this overwrites the original data. Hence we get the outcome we have on the app
        } catch {
            print("Error catching the encoded array, \(error)")
        }
    }
    
    mutating func loadItems() {
        print("Loading items")
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                self.itemArray = try decoder.decode([Item].self, from: data)
                print("array =", self.itemArray.count)
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
    }
    
    
}
