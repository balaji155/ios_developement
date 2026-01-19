//
//  ViewController.swift
//  Project2
//
//  Created by balaji.papisetty on 11/10/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAsked = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score Board", style: .done, target: self, action: #selector(showScoreBoard))
        countries += ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
        button1.configuration?.contentInsets = .zero
        button2.configuration?.contentInsets = .zero
        button3.configuration?.contentInsets = .zero
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//          print("comming")
//          button1.layer.borderColor = UIColor.lightGray.cgColor
//          button2.layer.borderColor = UIColor.lightGray.cgColor
//          button3.layer.borderColor = UIColor.lightGray.cgColor
//          
//          button1.layer.borderWidth = 1
//          button2.layer.borderWidth = 1
//          button3.layer.borderWidth = 1
//    }
    
    func askQuestion(action: UIAlertAction! = nil){
        print(questionsAsked)
        if questionsAsked == 10 {
            showAlert(title: "Questions completed", message: "Final Score: \(score)",handlerAction: .none)
            questionsAsked = 0
            score = 0
        }

        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased() + " " + "Score: \(score)"
        questionsAsked+=1
    }
    
    @objc func showScoreBoard(){
        showAlert(title: "Score Board", message: "Score: \(score)",handlerAction: .none)
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
       if sender.tag == correctAnswer {
            score+=1
            askQuestion()
        }else{
            score-=1
            showAlert(title: "Wrong Answer", message: "You've selected the flag of \(countries[sender.tag].uppercased())",handlerAction: askQuestion)
        }
    }
    
    func showAlert(title: String,message: String,handlerAction: ((UIAlertAction) -> Void)? = nil){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: handlerAction))
        
        present(ac, animated: true)
    }
    
  
    
}

