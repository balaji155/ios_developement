//
//  ViewController.swift
//  project5
//
//  Created by balaji.papisetty on 23/10/25.
//

import UIKit

class ViewController: UITableViewController {
   
    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Start", style: .plain, target: self, action: #selector(startGame))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptAnswerAlert))
        
        
        
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: ".txt"){
            if let startWords = try? String(contentsOf: startWordsUrl, encoding: .utf8){
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty{
            allWords = ["silkworm"]
        }
        
        startGame()
    }
    
    @objc func startGame(){
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptAnswerAlert(){
        let ac = UIAlertController(title: "Answer here", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitBtn = UIAlertAction(title: "Submit", style: .default){
            [weak self,weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            
            self?.submit(answer)
        }
        ac.addAction(submitBtn)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func submit(_ answer:String){
        let lowerAns = answer.lowercased()
        
        guard isPossible(word: lowerAns) else {
            showErrorAlert(errorTitle: "Word not possible", errorMessage: "You can't make the word from \(title!.lowercased())")
            return
        }
        
        guard isReal(word: lowerAns) else {
            showErrorAlert(errorTitle: "Word can't recoginized", errorMessage: "Please check your spelling")
            return
        }
        
        guard isOriginal(word: lowerAns) else {
            showErrorAlert(errorTitle: "Word Already Used", errorMessage:"Please choose a different word")
            return
        }
        
        guard isSameInput(word: lowerAns) else {
            showErrorAlert(errorTitle: "Word can't be same", errorMessage: "Please choose a different word")
            return
        }
        
        usedWords.insert(lowerAns, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
                    
           
    }
    
    func isPossible(word:String) -> Bool{
        guard var tempWord = title?.lowercased() else { return false }
        for letter in word{
            if let index = tempWord.firstIndex(of: letter){
                tempWord.remove(at: index)
            }else{
                return false
            }
        }
        return true
    }
    
    func isReal(word:String) -> Bool{
        if word.utf16.count < 3 { return false }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let missSpell = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return missSpell.location == NSNotFound
    }
    
    func isOriginal(word:String) -> Bool{
        return !usedWords.contains(word)
    }
    
    func isSameInput(word:String) -> Bool{
        print(title!.lowercased(),word)
        return !(title!.lowercased() == word)
    }
    
    func showErrorAlert (errorTitle: String,errorMessage: String){
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    


}

