//
//  ViewController.swift
//  TableViews
//
//  Created by Kelby Mittan on 11/11/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK:- outlets and properties
    @IBOutlet weak var tableView: UITableView!
    
    private var countries = [Country]() { // empty array
        didSet {
            // reload tableView
            tableView.reloadData()
        }
    }
    
    private var sortAscending = false
    
//    private var countries = Country.countries
    
    // MARK:- viewcontroller life cycle and methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the data source object
        // meaning the object that will provide the tableView its data (cell data)
        tableView.dataSource = self  // is the viewcontroller instance e.g. self
        
        // testing data
        print("There are \(Country.countries.count) countries in our struct")
        sortData(true)
    }
    @IBAction func sortButtonPressed(_ sender: UIBarButtonItem) {
        sortAscending.toggle()
        sortData(sortAscending)
    }
    
    func sortData(_ sortAscending: Bool) {
        if sortAscending {
            countries = Country.countries.sorted { $0.name < $1.name}
            // our tabel view reloads because we are using a property observer didSet
            navigationItem.rightBarButtonItem?.title = "Sort Ascending"
        } else {
            countries = Country.countries.sorted { $0.name > $1.name}
            navigationItem.rightBarButtonItem?.title = "Sort Descending"
        }
    }
}


// step 2: conform to UITableViewDataSource
extension ViewController: UITableViewDataSource {
    // 2 required methods
    
    // method 1: number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    // method 2:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // dequeueReusableCell:
        // recycles a cell if it exists
        // if the cell does not exist a new cell is created
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        
        // get the object (country) at the current indexPath
        
        let country = countries[indexPath.row]
        
        // configure the cell
        cell.textLabel?.text = country.name
        cell.detailTextLabel?.text = country.description
//        let arrOfArrays = [[1,2,3],
//        [4,5,6],
//        [7,8,9]]
//        arrOfArrays[0][0] // prints out 1
//        arrOfArrays[indexPath.section][indexPath.row]
        
//        let flatArr = [1,2,3]
//        flatArr[indexPath.row]
        return cell
    }
    
    
}
