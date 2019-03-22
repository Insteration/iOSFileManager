//
//  TableViewController.swift
//  FileManager
//
//  Created by Artem Karmaz on 3/22/19.
//  Copyright © 2019 Artem Karmaz. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let array = ["Get Info", "Clear Log", "Create File", "Create Dir", "Delete", "Get Documents Path"]
    
    var fileManager = FileManagement()
    let mainVC = ViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.isScrollEnabled = false
    }

    override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: 250, height: tableView.contentSize.height)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let textData = array[indexPath.row]
        cell.textLabel?.text = textData
        
        return cell
    }
 
    // MARK: - Check on select
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.row {
        case 0:
            FileManagement.commandValue = 0
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FileManagerCommand"), object: nil)
        case 1:
            FileManagement.commandValue = 1
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FileManagerCommand"), object: nil)
        case 2:
            FileManagement.commandValue = 2
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FileManagerCommand"), object: nil)
        case 3:
            FileManagement.commandValue = 3
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FileManagerCommand"), object: nil)
        case 4:
            FileManagement.commandValue = 4
            alert()
        case 5:
            FileManagement.commandValue = 5
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FileManagerCommand"), object: nil)
        default:
            ()
        }
    }
}

extension TableViewController {
    
    // MARK: - Add Alert Controller For Delete Item
    
    private func alert() {
        let alert = UIAlertController(title: "Warning", message: "Are you sure you want to delete the item?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {_ in NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FileManagerCommand"), object: nil)})
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}