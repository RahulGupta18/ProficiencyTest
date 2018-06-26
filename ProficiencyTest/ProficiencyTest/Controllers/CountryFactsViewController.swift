//
//  CountryFactsViewController.swift
//  ProficiencyTest
//
//  Created by Mac_Admin on 20/06/18.
//  Copyright © 2018 Infosys Ltd. All rights reserved.
//

import UIKit
import SDWebImage

class CountryFactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView = UITableView()
    let refreshButton = UIButton()//Mean to show  when no data(not finish)
    let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var countryFact: CountryFacts?
    var isDataGettingLoaded = false
    
    // MARK: - View Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       // setViews()
        
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
    
    func setViews() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(CountryFactsViewController.refresh))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FactCell.self, forCellReuseIdentifier: "FactCell")
        view.addSubview(tableView)
        view.addSubview(indicatorView)
        
        indicatorView.hidesWhenStopped = true;
        
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
    
    //MARK: Table View Delegate & DataSource
    
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
    
    //MARK: Actions
    
    @objc func refresh() {
        
        if Utility.isConnectedToNetwork() == true {
            
            loadData()
            
        } else {
            
            Utility.showAlert(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", buttonText: "OK", viewController: self)
        }
    }
    
    // MARK: - Custom Methods
    
    func loadData() {
        
        NetworkManager.getDataFromServer { [weak self] (facts, err) in
            
            if let factList = facts {
                
                self?.countryFact = factList
                
                self?.tableView.reloadData()
            }
        }
    }

}

