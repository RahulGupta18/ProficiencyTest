//
//  Fact.swift
//  ProficiencyTest
//
//  Created by Mac_Admin on 20/06/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import Foundation

struct Fact: Decodable {
    
    let title: String?
    let description: String?
    let imageHref: String?
    
    func titleIsNullOrEmpty() -> Bool {
        if let title = title, !title.isEmpty {
            return true
        }
        return false
    }
}
