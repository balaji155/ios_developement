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
        let tag =  navigationController?.tabBarItem.tag ?? 0
        DispatchQueue.global(qos: .userInitiated).async {
            [weak self] in
            self?.fetchJSON(tag)
        }
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
    
    @objc func fetchJSON(_ tag: Int) {
     
        let urlString: String
        if tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        guard let url = URL(string: urlString) else { return }
            if let data = try? Data(contentsOf: url){
                parseJSON(data: data)
            }else {
                DispatchQueue.main.async {
                    [weak self] in
                    self?.showError()
                }
            }
           
        }
    
    @objc func parseJSON( data: Data){
        let decoder = JSONDecoder()
        
        if let decoderData = try? decoder.decode(Petitions.self, from: data) {
            DispatchQueue.main.async {
                [weak self] in
                self?.petitionsList = decoderData.results
                self?.filteredPetitionsList = decoderData.results
                self?.tableView.reloadData()
            }
        }else {
            DispatchQueue.main.async {
                [weak self] in
                self?.showError()
            }
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            [weak self] in
            let ac = UIAlertController(title: "Loading error", message: "Something went wrong please check your internet connection", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            self?.present(ac, animated: true)
        }
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
        var tempFilterData = [Petition]()
        DispatchQueue.global(qos: .userInitiated).async {
            [weak self] in
            guard let self = self else { return }
            if text.isEmpty {
                tempFilterData = self.petitionsList
            } else {
                tempFilterData = self.petitionsList.filter {
                    $0.title.lowercased().contains(text.lowercased()) ||
                    $0.body.lowercased().contains(text.lowercased())
                }
            }
            DispatchQueue.main.async {
                [weak self] in
                self?.filteredPetitionsList = tempFilterData
                self?.tableView.reloadData()
            }
        }
    }


}

