//
//  ViewController.swift
//  TodoList-iOS
//
//  Created by lutfi on 22/10/19.
//  Copyright © 2019 mlutfiibra. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
//    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let newItem = Item()
//        newItem.title = "John"
//        newItem.done = true
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "George"
//        newItem2.done = false
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Paul"
//        newItem3.done = true
//        itemArray.append(newItem3)
//
//        let newItem4 = Item()
//        newItem4.title = "Ringo"
//        newItem4.done = false
//        itemArray.append(newItem4)
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        
        loadItems()
    }

    //MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "TodoItemCell")
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        self.saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add Button
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if(textField.text != "") {
                let newItem = Item()
                newItem.title = textField.text!
                
                self.itemArray.append(newItem)
                
                self.saveItems()
                
//                self.defaults.set(self.itemArray, forKey: "TodoListArray")
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new todo"
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
            print("Error encoding app")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error loading data \(error)")
            }
            
        }
        
    }
    
}

