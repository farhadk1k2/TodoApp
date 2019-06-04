//
//  ViewController.swift
//  TodoApp
//
//  Created by farhad keyvan ghazvini on 6/4/19.
//  Copyright © 2019 farhad keyvan ghazvini. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {

    var itemArray = ["first task","second one","lastly the third one"]
    
    var defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "todoListArray") as? [String]{
            itemArray = items
        }
    }

    //MARK - bind tableViewController cells datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK - tableview delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new todo item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when the button is pressed
            self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "todoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a new Item"
            
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    

}

