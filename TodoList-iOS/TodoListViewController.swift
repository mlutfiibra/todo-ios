//
//  ViewController.swift
//  TodoList-iOS
//
//  Created by lutfi on 22/10/19.
//  Copyright © 2019 mlutfiibra. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let itemArray = ["Order Boba", "Sleep", "Playing Game"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "TodoItemCell")
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
}

