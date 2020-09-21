//
//  ForefeitListController.swift
//  Forefit
//
//  Created by Edward Raven on 20/09/2020.
//  Copyright © 2020 Edward Raven. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    // Create a new array of item objects created from the item class
    var itemArray = [Item]()
    
    // Create a variable to hold the data URL of the filepath for the plist that contains the data to be saved
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    // Runs when the program loads
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath!)
        loadItems()
    }
    
    // Returns the number of columns (sections) only ever 1 section so hard coded to 1
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Returns the number of items in the array of items pulled from the item array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    // Function that runs when the user clicks on the item displayed in the table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        
        // Gets the title of the item of the item that the user has pressed
        let item = itemArray[indexPath.row]
        
        // adds the title value to the newly formed item
        cell.textLabel?.text = item.title
        
        // Defines the accessory of the checkmark to be able to be displayed
        // Ternary Operator ==>
        // Value = Condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        
        // If the user clicks on an item it will be marked with a tick to show it has been completed
        if item.done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        // Return the cell value to the table to be dispalyed
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.reloadData()
        
        // Prevent the selected row from staying highlighted
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        // Local variable to hold the value of the new item to be added
        var textField = UITextField()
        
        // Pop-Up to show allowing the user to enter a new todo item
        // Then append this item into the itemArray
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        // Completion block that runs when the user has pressed the add item button
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What will happen once the user clicks the Add Item button on our UIAlert
            // Add the new item to the array
            // self.itemArray.append(textField.text!)
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            // Save the updated item array to the user defaults
            // (value, key for that value)
            // self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            
            // Extends the scope of the alertTextfield to the textField function variable
            textField = alertTextField
        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error catching the encoded array, \(error)")
        }
        
        // Reload the table to show the new data
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                    print("Error decoding item array, \(error)")
                    }
            }
        }
    
}
