//
//  Person.swift
//  project10
//
//  Created by balaji.papisetty on 24/11/25.
//

import UIKit

class Person: NSObject {
    var name: String
    var imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
