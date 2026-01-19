//
//  ViewController.swift
//  project8
//
//  Created by balaji.papisetty on 07/11/25.
//

import UIKit

class ViewController: UIViewController {
    
    var scoreLabel: UILabel!
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswerTextField: UITextField!
    var letterButtons = [UIButton]()
    
    var activeButtons = [UIButton]()
    var sollutions = [String]()
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1
    var correctlyAnsweredCount = 0
    
    override func loadView() {
        print("Load View")
        view = UIView()
        view.backgroundColor = .white
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = .systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        cluesLabel.numberOfLines = 0
        view.addSubview(cluesLabel)
        
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = .systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.textAlignment = .right
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        answersLabel.numberOfLines = 0
        view.addSubview(answersLabel)
        
        currentAnswerTextField = UITextField()
        currentAnswerTextField.translatesAutoresizingMaskIntoConstraints = false
        currentAnswerTextField.placeholder = "Tap letters to guess answer"
        currentAnswerTextField.font = .systemFont(ofSize: 44)
        currentAnswerTextField.textAlignment = .center
        currentAnswerTextField.isUserInteractionEnabled = false
        view.addSubview(currentAnswerTextField)
        
        let submitBtn = UIButton(type: .system)
        submitBtn.translatesAutoresizingMaskIntoConstraints = false
        submitBtn.setTitle("SUBMIT", for: .normal)
        submitBtn.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submitBtn)
        
        let clearBtn = UIButton(type: .system)
        clearBtn.translatesAutoresizingMaskIntoConstraints = false
        clearBtn.setTitle("CLEAR", for: .normal)
        clearBtn.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clearBtn)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(buttonsView)
        
        

        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            cluesLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6, constant: -100),
            
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            answersLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4, constant: -100),
            
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            
            currentAnswerTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswerTextField.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor,constant: 20),
            currentAnswerTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            submitBtn.topAnchor.constraint(equalTo: currentAnswerTextField.bottomAnchor),
            submitBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submitBtn.heightAnchor.constraint(equalToConstant: 44),
            
            clearBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clearBtn.centerYAnchor.constraint(equalTo: submitBtn.centerYAnchor),
            clearBtn.heightAnchor.constraint(equalToConstant: 44),
            
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.topAnchor.constraint(equalTo: submitBtn.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])
        
        let widthBtn = 150
        let heightBtn = 80
        
        for row in 0..<4 {
            for col in 0..<5 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = .systemFont(ofSize: 36)
                letterButton.setTitle("WWW", for: .normal)
                let frame = CGRect(x: col * widthBtn, y: row * heightBtn, width: widthBtn, height: heightBtn)
                letterButton.frame = frame
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadLevel()
    }
    
    @objc func submitTapped(_ sender: UIButton) {
        guard let answer = currentAnswerTextField.text else { return }
        if let solutionIndex = sollutions.firstIndex(of: answer) {
            activeButtons.removeAll()
            var solutionAnswerLabel = answersLabel.text?.components(separatedBy: "\n")
            solutionAnswerLabel?[solutionIndex] = answer
            answersLabel.text = solutionAnswerLabel?.joined(separator: "\n")
            
            score += 1
            correctlyAnsweredCount += 1
            currentAnswerTextField.text = ""
            if correctlyAnsweredCount % 7 == 0 {
                let ac = UIAlertController(title: "Congratulations!", message: "You have cleared the level! Are you ready for the next level?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
                present(ac,animated: true)
            }
        }else {
            score -= 1
            for button in activeButtons {
                button.isHidden = false
            }
            activeButtons.removeAll()
            currentAnswerTextField.text = ""
            let ac = UIAlertController(title: "Incorrect Guess!", message: "Please try again", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
        }
        
        
    }
    
    func levelUp(_ action: UIAlertAction) {
        level += 1
        sollutions.removeAll(keepingCapacity: true)
        
        loadLevel()
        
        for button in letterButtons {
            button.isHidden = false
        }
        
    }
    
    @objc func clearTapped() {
        currentAnswerTextField.text = ""
        
        for button in activeButtons {
            button.isHidden = false
        }
        
        activeButtons.removeAll()
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let letter = sender.titleLabel?.text else { return }
        
        currentAnswerTextField.text = currentAnswerTextField.text?.appending(letter)
        sender.isHidden = true
        activeButtons.append(sender)
    }
    
    func loadLevel() {
        var cluesString = ""
        var solutionsString = ""
        var solutionBits = [String]()
        var tempSolutions = [String]()
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            guard let self = self else { return }
            
            if let url = Bundle.main.url(forResource: "level\(self.level)", withExtension: "txt"),
               let fileString = try? String(contentsOf: url,encoding: .utf8) {
                
                let lines = fileString.components(separatedBy: "\n")
                
                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    cluesString += "\(index + 1). \(clue)\n"
                    
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionsString += "\(solutionWord.count)\n"
                    
                    tempSolutions.append(solutionWord)  // temporary -> safe
                    
                    let bits = answer.components(separatedBy: "|")
                    solutionBits += bits
                }
            }
            solutionBits.shuffle()
            
            // Now update UI safely on main thread
            DispatchQueue.main.async {
                self.cluesLabel.text = cluesString.trimmingCharacters(in: .whitespacesAndNewlines)
                self.answersLabel.text = solutionsString.trimmingCharacters(in: .whitespacesAndNewlines)
                
                self.sollutions = tempSolutions  // assign solutions safely
                
                if self.letterButtons.count == solutionBits.count {
                    for i in 0..<self.letterButtons.count {
                        self.letterButtons[i].setTitle(solutionBits[i], for: .normal)
                    }
                }
            }
        }
    }
}

