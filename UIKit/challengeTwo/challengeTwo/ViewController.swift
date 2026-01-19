//
//  ViewController.swift
//  challengeTwo
//
//  Created by balaji.papisetty on 01/11/25.
//

import UIKit

class ViewController: UITableViewController {
    var itemList = [String]()
    var firstRightBarItem: UIBarButtonItem!
    var secondRightBarItem: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstRightBarItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addItem))
        
        secondRightBarItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareData))
        
        navigationItem.rightBarButtonItems = [secondRightBarItem,firstRightBarItem]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(loadData))
        
        updateClearBtnState()
    }
    
    @objc func loadData() {
        title = "Add Items"
        itemList.removeAll(keepingCapacity: true)
        tableView.reloadData()
        updateClearBtnState()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
        cell.textLabel?.text = itemList[indexPath.row]
        return cell
    }
    
    @objc func addItem() {
        let ac = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let addItemAction = UIAlertAction(title: "Add", style: .default) {
            [weak self,weak ac] _ in
            guard let text = ac?.textFields?[0].text else { return }
            self?.add(text)
        }
        ac.addAction(addItemAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func add(_ text: String) {
        itemList.insert(text, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        updateClearBtnState()
    }
    
    func updateClearBtnState() {
        navigationItem.leftBarButtonItem?.isEnabled = !itemList.isEmpty
        navigationItem.rightBarButtonItems?.first?.isEnabled = !itemList.isEmpty
    }
    
    @objc func shareData() {
        guard !itemList.isEmpty else { return }
        let completList = itemList.joined(separator: "\n")
        let activityVc = UIActivityViewController(activityItems: [completList], applicationActivities: nil)
        
        present(activityVc, animated: true)
    }


}

