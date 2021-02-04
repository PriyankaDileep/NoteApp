//
//  Note.swift
//  SimpleNotes
//
//  Created by Priyanka PS on 2/2/21.
//

import Foundation

struct Note {
    var Title: String
    var Description: String

    
    var dictionary: [String: Any] {
        return["Title" : Title, "Description" : Description]
    }
}

extension Note {
    init?(dictionary: [String : Any]) {
            guard let Title = dictionary["title"] as? String,
                let Description = dictionary["Description"] as? String
                else { return nil }
            
        self.init(Title:Title,Description:Description)
        }
}
