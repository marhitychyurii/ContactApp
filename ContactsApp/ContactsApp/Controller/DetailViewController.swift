//
//  ContactViewController.swift
//  ContactsApp
//
//  Created by Юра Маргітич on 15.08.2021.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var contactNameLabel: UILabel!
    @IBOutlet private weak var contactPhoneNumberLabel: UILabel!
    @IBOutlet private weak var contactImage: ContactPhoto!
    
    var contact: Contact?
    
    override func loadView() {
        super.loadView()
        guard let contact = self.contact else { return }
        initializeWith(contact)
    }
    
    private func initializeWith(_ contact: Contact) {
        contactNameLabel.text = contact.name
        contactPhoneNumberLabel.text = contact.phoneNumber
        contactImage.image = UIImage(named: contact.name) ?? UIImage(systemName: "person.fill")
    }
}
