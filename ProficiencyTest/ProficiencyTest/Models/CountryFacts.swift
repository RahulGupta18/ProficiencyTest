//
//  CountryFacts.swift
//  ProficiencyTest
//
//  Created by Mac_Admin on 20/06/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import Foundation

struct CountryFacts: Decodable {
    
    let title: String?
    var factList: [Fact]?

    private enum Keys: String, CodingKey {
        case title
        case factList = "rows"
    }
    
    init(from decoder: Decoder) throws  {
        let values = try decoder.container(keyedBy: Keys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        factList = try values.decodeIfPresent([Fact].self, forKey: .factList)
    }
}
