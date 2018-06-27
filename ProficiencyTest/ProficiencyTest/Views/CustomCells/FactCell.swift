//
//  FactCell.swift
//  ProficiencyTest
//
//  Created by Mac_Admin on 22/06/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import Foundation
import UIKit

class FactCell: UITableViewCell {
    
    var imgViw = UIImageView()
    var lblTitle: UILabel = UILabel()
    var lblDesc: UILabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setViews()
    }
    
    func setViews() {
        
        lblTitle.numberOfLines = 1
        lblTitle.textAlignment = .left
        lblTitle.textColor = UIColor.black
        lblTitle.font = UIFont.systemFont(ofSize: 13)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        lblDesc.numberOfLines = 0
        lblDesc.textAlignment = .left
        lblDesc.textColor = UIColor.black
        lblDesc.font = UIFont.systemFont(ofSize: 12)
        lblDesc.translatesAutoresizingMaskIntoConstraints = false

        imgViw.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(imgViw)
        contentView.addSubview(lblTitle)
        contentView.addSubview(lblDesc)
        
        setConstraints()
    }
    
    func setConstraints() {
        
        //ImageView constraints
        let viewsDictionary = ["image": imgViw, "title": lblTitle, "description": lblDesc] as [String : Any]
        let constraintHeight = NSLayoutConstraint.constraints(withVisualFormat: "H:[image(64)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        let constraintV = NSLayoutConstraint.constraints(withVisualFormat: "V:[image(64)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        let constraintH = NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[image]", options: NSLayoutFormatOptions.alignAllTop, metrics: nil, views: viewsDictionary)
        imgViw.addConstraints(constraintHeight)
        imgViw.addConstraints(constraintV)
        
        //Title Label constraints
        let marginsDictionary = ["leftMargin": 8, "rightMargin": 8, "viewSpacing": 8]
        let constraintTitleH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-leftMargin-[image]-viewSpacing-[title]-rightMargin-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: marginsDictionary, views: viewsDictionary)
        let constraintTitleV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[title]", options: NSLayoutFormatOptions.alignAllTop, metrics: nil, views: viewsDictionary)
        
        //Description Label constraints
        let viewSpacing: CGFloat = 8
        let constraintDescV = NSLayoutConstraint(item: lblDesc, attribute: .top, relatedBy: .equal, toItem: lblTitle, attribute: .bottom, multiplier: 1.0, constant: viewSpacing)
        let constraintDescH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-leftMargin-[image]-viewSpacing-[description]-rightMargin-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: marginsDictionary, views: viewsDictionary)
        
    
        let bottomMargin: CGFloat = 8
        let constraintDescBottom = NSLayoutConstraint(item: lblDesc, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: -bottomMargin)
        constraintDescBottom.priority = UILayoutPriority(rawValue: 999)
        
        let descMinHeight: CGFloat = 40
        let constraintDescHeight = NSLayoutConstraint(item: lblDesc, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: descMinHeight)
        constraintDescHeight.priority = UILayoutPriority(rawValue: 1000)
        lblDesc.addConstraint(constraintDescHeight)
        
        contentView.addConstraints(constraintH)
        contentView.addConstraints(constraintTitleH)
        contentView.addConstraints(constraintTitleV)
        contentView.addConstraint(constraintDescV)
        contentView.addConstraints(constraintDescH)
        contentView.addConstraint(constraintDescBottom)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
}
