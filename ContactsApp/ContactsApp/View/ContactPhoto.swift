//
//  ContactPhoto.swift
//  ContactsApp
//
//  Created by Юра Маргітич on 15.08.2021.
//

import UIKit

class ContactPhoto: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        layer.cornerRadius = frame.size.width / 2
    }
}
