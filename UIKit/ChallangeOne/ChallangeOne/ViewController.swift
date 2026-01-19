//
//  ViewController.swift
//  ChallangeOne
//
//  Created by balaji.papisetty on 14/10/25.
//

import UIKit

class ViewController: UITableViewController {
    var pictureNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Flags"
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        for item in items {
            if item.hasSuffix(".png") {
                pictureNames.append(item)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictureNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "picture",for: indexPath)
        cell.textLabel?.text = pictureNames[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictureNames[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

