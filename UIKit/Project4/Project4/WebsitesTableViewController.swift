//
//  WebsitesTableViewController.swift
//  Project4
//
//  Created by balaji.papisetty on 20/10/25.
//

import UIKit

class WebsitesTableViewController: UITableViewController {
    var websitesList = ["apple.com","hackingwithswift.com","google.com"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websitesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
        cell.textLabel?.text = websitesList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WebsiteVC") as? ViewController {
            vc.websiteName = websitesList[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
