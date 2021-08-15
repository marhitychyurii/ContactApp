//
//  PersistencyHelper.swift
//  test
//
//  Created by Юра Маргітич on 15.08.2021.
//

import Foundation

class PersistencyHelper {
    static func saveContacs(_ contacts: [Contact]) {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(contacts)
            try data.write(to: dataFilePath(), options: .atomic)
        } catch {
            print("Error encoding: \(error.localizedDescription)")
        }
    }
    
    static func loadContacs() -> [Contact] {
        var contacts = [Contact]()
        if let data = try? Data(contentsOf: dataFilePath()) {
            let decoder = PropertyListDecoder()
            do {
                contacts = try decoder.decode([Contact].self, from: data)
            } catch {
                print("Error decoding: \(error.localizedDescription)")
            }
        }
        return contacts
    }
    
    
    static func dataFilePath() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("Contacts.plist")
    }
}
