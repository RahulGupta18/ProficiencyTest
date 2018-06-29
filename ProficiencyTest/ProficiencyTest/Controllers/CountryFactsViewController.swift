//
//  CountryFactsViewController.swift
//  ProficiencyTest
//
//  Created by Mac_Admin on 20/06/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import UIKit
import SDWebImage

class CountryFactsViewController: UIViewController {

    let tableView = UITableView()
    let refreshButton = UIButton()//Mean to show  when no data(not finish)
    let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    open var countryFact: CountryFacts?
    var isLoading = false
    
    // MARK:- View Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    convenience init() {
        self.init(nibName:nil, bundle:nil)
        
        self.view.backgroundColor = UIColor.white
        
        setViews()
        setConstraints()
    }
    
    // MARK:- Custom Methods
    
    func loadData() {
        
        if (Utility.isConnectedToNetwork()) {
            isLoading = true
            indicatorView.startAnimating()
            
            NetworkManager.getDataFromServer { [weak self] (facts, err) in
                
                self?.isLoading = false
                self?.indicatorView.stopAnimating()
                
                if let countryFacts = facts {
                    self?.countryFact = countryFacts
                    self?.countryFact?.factList = countryFacts.factList?.filter({$0.title != nil})
                    self?.title = self?.countryFact?.title
                    self?.tableView.reloadData()
                } else if let error = err {
                    Utility.showAlert(title: Constants.ALERT_ERROR_TITLE, message: error.localizedDescription, buttonText: Constants.ALERT_OK, viewController: self!)
                }
            }
        } else {
            Utility.showAlert(title: Constants.ALERT_NO_INTERNET_TITLE, message: Constants.ALERT_NO_INTERNET_MSG, buttonText: Constants.ALERT_OK, viewController: self)
        }
    }
    
    func setViews() {
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(CountryFactsViewController.refresh))
        refreshButton.accessibilityIdentifier = "refreshButton"
        
        self.navigationItem.rightBarButtonItem = refreshButton
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FactCell.self, forCellReuseIdentifier: "FactCell")
        view.addSubview(tableView)
        view.addSubview(indicatorView)
        
        tableView.accessibilityIdentifier = "factsTable"
        indicatorView.hidesWhenStopped = true;
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    func setConstraints() {
        // tableview constraint
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        let viewsDictionary = ["tableView": tableView]
        let constraintV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tableView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        let constraintH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        view.addConstraints(constraintH)
        view.addConstraints(constraintV)
        
        // indicatorView constraint
        self.indicatorView.translatesAutoresizingMaskIntoConstraints = false;
        let constraintX = NSLayoutConstraint(item: indicatorView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0)
        let constraintY = NSLayoutConstraint(item: indicatorView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0)
        view.addConstraint(constraintX)
        view.addConstraint(constraintY)
        
    }
    
    //MARK:- Actions
    
    @objc func refresh() {
        if !isLoading {
            loadData()
            
        }
    }
}

