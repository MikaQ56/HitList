//
//  ViewController.swift
//  HitList
//
//  Created by Mickael on 21/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit
import CoreData

// MARK: - Properties & outlets
class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var peopleService = PeopleService()
    var appDelegate: AppDelegate!
}

// MARK: - Life cycle's controller
extension ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "The List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        self.appDelegate = appDelegate
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        peopleService.fetch(appDelegate: appDelegate)
    }
}

// MARK: -Action
extension ViewController {
    
    @IBAction func addName(_ sender: UIBarButtonItem) {
        createAlertTextFieldWithActions()
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return peopleService.people.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let person = peopleService.people[indexPath.row]
            let cell =
                tableView.dequeueReusableCell(withIdentifier: "Cell",
                                              for: indexPath)
            cell.textLabel?.text =
                person.value(forKeyPath: "name") as? String
            return cell
    }
}

// MARK: - Alert
extension ViewController {
    func createAlertTextFieldWithActions() {
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else {
                    return
            }
            self.peopleService.save(name: nameToSave, appDelegate: self.appDelegate)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}



