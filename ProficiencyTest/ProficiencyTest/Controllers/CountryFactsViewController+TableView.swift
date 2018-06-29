//
//  CountryFactsViewController+TableView.swift
//  ProficiencyTest
//
//  Created by Mac_Admin on 29/06/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import Foundation
import UIKit

extension CountryFactsViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK:- Table View Delegate & DataSource
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countryFact?.factList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FactCell = tableView.dequeueReusableCell(withIdentifier: "FactCell", for: indexPath) as! FactCell
        
        if let facts = self.countryFact {
            if let factItem = facts.factList?[indexPath.row] {
                cell.lblTitle.text = factItem.title
                cell.lblDesc.text = factItem.description
                cell.imgViw.backgroundColor = UIColor.clear
                cell.imgViw.image = UIImage(named: "placeholder")
                
                if let imgURL = factItem.imageHref {
                    let urlString = imgURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                    cell.imgViw.sd_setImage(with: URL(string: urlString!), placeholderImage: UIImage(named: "placeholder"))
                }
            }
        }
        return cell
    }
}
