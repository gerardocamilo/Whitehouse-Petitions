//
//  ViewController.swift
//  Whitehouse Petitions
//
//  Created by Gerardo Camilo on 5/13/17.
//  Copyright © 2017 Gerardo Camilo. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let json = try? JSON(data: data)
                
                if json?["metadata"]["responseInfo"]["status"].intValue == 200 {
                        parse(json: json!)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let petition = petitions[indexPath.row]
        
        cell.textLabel?.text = petition["title"]
        cell.detailTextLabel?.text = petition["body"]
        return cell
    }
    
    func parse(json: JSON) {
        
        for result in json["results"].arrayValue {
            let title = result["title"].stringValue
            let body = result["body"].stringValue
            let sigs = result["signatureCount"].stringValue
            let obj = ["title": title, "body": body, "sigs": sigs]
            petitions.append(obj)
            
        }
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }

} // End - Class ViewController












