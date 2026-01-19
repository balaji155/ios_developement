//
//  PlayingCardsVC.swift
//  PlayinCards_Programatic
//
//  Created by balaji.papisetty on 11/08/25.
//

import UIKit

class PlayingCardsVC: UIViewController {
    
    let CardImageView = UIImageView()
    let stopButton = PCButton(color: .systemRed, title: "Stop!",systemImageName: "stop.circle")
    let resetButton = PCButton(color: .systemGreen, title: "Reset",systemImageName: "arrow.clockwise.circle")
    let rulesButton = PCButton(color: .systemBlue, title: "Rules",systemImageName: "list.bullet")
    let cards: [UIImage] = Cards.allCards
    var timer : Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
        showCards()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }
    
    func configureUI() {
        configureImageView()
        configureStopButton()
        configureResetButton()
        configureRulesButton()
    }
    
    func configureImageView() {
        view.addSubview(CardImageView)
        CardImageView.translatesAutoresizingMaskIntoConstraints = false
        CardImageView.image = UIImage(named: "AS")
        
        NSLayoutConstraint.activate([
            CardImageView.widthAnchor.constraint(equalToConstant: 250),
            CardImageView.heightAnchor.constraint(equalToConstant: 350),
            CardImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            CardImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -75)
        ])
    }
    
    func configureStopButton() {
        view.addSubview(stopButton)
        stopButton.addTarget(self, action: #selector(handleStopButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            stopButton.widthAnchor.constraint(equalToConstant: 260),
            stopButton.heightAnchor.constraint(equalToConstant: 50),
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.topAnchor.constraint(equalTo: CardImageView.bottomAnchor, constant: 30)
        ])
    }
    
    func configureResetButton() {
        view.addSubview(resetButton)
        resetButton.addTarget(self, action: #selector(handleRestartButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            resetButton.widthAnchor.constraint(equalToConstant: 115),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            resetButton.leadingAnchor.constraint(equalTo: stopButton.leadingAnchor),
            resetButton.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: 25)
        ])
    }
    
    func configureRulesButton() {
        view.addSubview(rulesButton)
        rulesButton.addTarget(self, action: #selector(handleRulesButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            rulesButton.widthAnchor.constraint(equalToConstant: 115),
            rulesButton.heightAnchor.constraint(equalToConstant: 50),
            rulesButton.trailingAnchor.constraint(equalTo: stopButton.trailingAnchor),
            rulesButton.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: 25)
        ])
    }
    
    @objc func handleRulesButtonTapped() {
        present(RulesVC(), animated: true)
    }
    
    func showCards() {
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(generateCard), userInfo: nil, repeats: true)
    }
    
    @objc func generateCard() {
        CardImageView.image = cards.randomElement() ?? UIImage(named: "AS")!
    }
    
    @objc func handleStopButtonTapped() {
        timer?.invalidate()
    }
    
    @objc func handleRestartButtonTapped() {
        timer?.invalidate()
        showCards()
    }
    
    

}
