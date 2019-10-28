//
//  CategoryViewController.swift
//  TodoList-iOS
//
//  Created by lutfi on 27/10/19.
//  Copyright © 2019 mlutfiibra. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CategoryCell")
        
        cell.textLabel?.text = categories[indexPath.row].name

        return cell
        
    }
    
    //MARK - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToItems") {
            
            let destinationVC = segue.destination as! TodoListViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categories[indexPath.row]
            }
            
        }
    }
    
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error context data \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    //MARK - Add new categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add", style: .default) { (action) in

            if(textField.text != "") {
                let newCategory = Category(context: self.context)

                newCategory.name = textField.text!

                self.categories.append(newCategory)

                self.saveCategories()
            }

        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new todo"
            textField = alertTextField
        }

        alert.addAction(action)

        present(alert, animated: true, completion: nil)

    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error fetching data \(error)")
        }
        
        tableView.reloadData()
        
    }
}
