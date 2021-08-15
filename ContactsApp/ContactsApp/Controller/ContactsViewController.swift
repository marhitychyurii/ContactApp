//
//  ContactsViewController.swift
//  test
//
//  Created by Юра Маргітич on 15.08.2021.
//

import UIKit

class ContactsViewController: UIViewController {
    
    private var contacts = [Contact]() {
        didSet {
            contacts = contacts.sorted { $0.name < $1.name }
        }
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - App's Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        contacts = PersistencyHelper.loadContacs()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        PersistencyHelper.saveContacs(contacts)
    }
    
    // MARK: - Actions
    @IBAction private func addButtonPressed() {
        let alert = UIAlertController(title: "ADD CONTACT", message: "Enter Contact's Name and its phone number", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "ADD", style: .default) { _ in
            if let contactName = alert.textFields?[0].text,
               let contactPhoneNumber = alert.textFields?[1].text {
                let contact = Contact(name: contactName, phoneNumber: contactPhoneNumber)
                self.contacts.append(contact)
                self.tableView.reloadData()
                PersistencyHelper.saveContacs(self.contacts)
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        
        alert.addTextField() { textField in
            textField.placeholder = "Contact's Name"
            textField.font = UIFont(name: "Avenir", size: 14)
        }
        alert.addTextField() { textField in
            textField.placeholder = "Contact's Phone Number"
            textField.font = UIFont(name: "Avenir", size: 14)
            textField.keyboardType = .phonePad
        }
        present(alert, animated: true, completion: nil)
    }
}

extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        let nameLabel = cell.viewWithTag(777) as! UILabel
        let phoneNumberLabel = cell.viewWithTag(666) as! UILabel
        
        nameLabel.text = contacts[indexPath.row].name
        phoneNumberLabel.text = contacts[indexPath.row].phoneNumber
        
        return cell
    }
}

extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let contact = contacts[indexPath.row]
        
        // Present DetailViewController
        guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as? DetailViewController else { return }
        detailViewController.contact = contact
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        contacts.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        PersistencyHelper.saveContacs(contacts)
    }
}

