//
//  ViewController.swift
//  project7
//
//  Created by balaji.papisetty on 01/11/25.
//

import UIKit

class ViewController: UITableViewController {
    var petitionsList = [Petition]()
    var filteredPetitionsList = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Petitions"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterTapped))
        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url){
                parseJSON(data: data)
                return
            }
        }
        
        showError()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitionsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let petition = filteredPetitionsList[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.petition = filteredPetitionsList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func parseJSON( data: Data){
        let decoder = JSONDecoder()
        
        if let decoderData = try? decoder.decode(Petitions.self, from: data) {
            petitionsList = decoderData.results
            filteredPetitionsList = decoderData.results
            tableView.reloadData()
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "Something went wrong please check your internet connection", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showCredits() {
        let ac = UIAlertController(title: "Credits", message: "Data comes from the We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    @objc func filterTapped(){
        let ac = UIAlertController(title: "Filter", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitBtn = UIAlertAction(title: "Filter", style: .default) {
            [weak self,weak ac] _ in
            if let answer = ac?.textFields?[0].text {
                self?.filterData(answer)
            }
        }
        ac.addAction(submitBtn)
        present(ac, animated: true)
    }
    
    func filterData(_ text: String){
        if text.isEmpty {
            filteredPetitionsList = petitionsList
        } else {
            filteredPetitionsList = petitionsList.filter {
                $0.title.lowercased().contains(text.lowercased()) ||
                $0.body.lowercased().contains(text.lowercased())
            }
        }
        tableView.reloadData()
    }


}

