//
//  ViewController.swift
//  challangethree
//
//  Created by balaji.papisetty on 20/11/25.
//

import UIKit

class ViewController: UIViewController {
    var guessingWord = "RYHTHEM"
    var wordTextField: UITextField!
    var letterButtons = [UIButton]()
    var activeButtons: [UIButton] = []
    var chancesLeft: Int! {
        didSet {
            chancesLabel.text = "Chances Left: \(chancesLeft ?? 0)"
        }
    }
    var chancesLabel: UILabel!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        chancesLabel = UILabel()
        chancesLabel.text = "Chances Left: \(guessingWord.count)"
        chancesLabel.textAlignment = .right
        chancesLabel.font  = UIFont.systemFont(ofSize: 18)
        chancesLabel.textColor = .black
        chancesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chancesLabel)
        
        wordTextField = UITextField()
        wordTextField.text = String(repeating: "?",count: guessingWord.count)
        wordTextField.translatesAutoresizingMaskIntoConstraints = false
        wordTextField.isEnabled = false
        wordTextField.font = UIFont.systemFont(ofSize: 20)
        wordTextField.textAlignment = .center
        wordTextField.textColor = .black
        wordTextField.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(wordTextField)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.borderColor = CGColor(gray: 0.2, alpha: 0.8)
        buttonsView.layer.cornerRadius = 8
        view.addSubview(buttonsView)
        
        let heightBtn = 60
        let widthBtn  = 60
        let rows = 6
        let cols = 5
        
        
        NSLayoutConstraint.activate([
            chancesLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            chancesLabel.widthAnchor.constraint(equalToConstant: 220),
            chancesLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,constant: -10),
            
            wordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordTextField.topAnchor.constraint(equalTo: chancesLabel.bottomAnchor, constant: 20),
            wordTextField.widthAnchor.constraint(equalToConstant: 220),
            
            buttonsView.topAnchor.constraint(equalTo: wordTextField.bottomAnchor, constant: 20),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.widthAnchor.constraint(equalToConstant: CGFloat(cols * widthBtn)),
            buttonsView.heightAnchor.constraint(equalToConstant: CGFloat(rows * heightBtn)),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10)
        ])
        

        let alphaBe = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var alphaBetArray = Array(alphaBe)
        alphaBetArray.shuffle()
        var alphaIndex = 0
        for row in 0..<rows {
            for col in 0..<cols {
                if alphaIndex >= alphaBetArray.count {
                    break
                }
                let letterBtn = UIButton(type: .system)
                letterBtn.titleLabel?.font = UIFont.systemFont(ofSize: 38)
                let alpahaBet = String(alphaBetArray[alphaIndex])
                letterBtn.setTitle(alpahaBet, for: .normal)
                let frame = CGRect(x: col * widthBtn,y: row * heightBtn,width: widthBtn,height: heightBtn)
                letterBtn.frame = frame
                letterBtn.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                buttonsView.addSubview(letterBtn)
                letterButtons.append(letterBtn)
                alphaIndex += 1
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        chancesLeft = guessingWord.count
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let letter = sender.currentTitle else { return }
        guard var newWord = wordTextField.text else { return }
        var pos = 0
        for char in guessingWord {
            if char == Character(letter) {
              let index = newWord.index(newWord.startIndex, offsetBy: pos)
                newWord.replaceSubrange(index...index, with: letter)
            }
            pos += 1
        }
        wordTextField.text = newWord
        sender.isHidden = true
        activeButtons.append(sender)
        if(newWord == guessingWord){
            showAlertVC(title: "You won!", message: "Restart the game to try again!")
        }
        chancesLeft -= 1
        print(chancesLeft ?? 0)
        if (chancesLeft ?? 0) == 0 {
                showAlertVC(title: "You lost!", message: "Restart the game to try again!")
        }
        print(newWord)
        
    }
    
    func showAlertVC(title: String,message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: restartGame))
        present(ac, animated: true)
    }
    
    func restartGame(_ action: UIAlertAction? = nil){
       for button in activeButtons {
            button.isHidden = false
        }
        activeButtons.removeAll(keepingCapacity: true)
        wordTextField.text = String(repeating: "?", count: guessingWord.count)
        chancesLeft = guessingWord.count
    }


}

