//
//  PlayingCardsVC.swift
//  PlayingCards
//
//  Created by balaji.papisetty on 06/08/25.
//

import UIKit

class PlayingCardsVC: UIViewController {

    @IBOutlet var cardImageView: UIImageView!
    var timer: Timer!
    var cards: [UIImage] = Card.allCards
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
    
    func startTimer() {
    timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(randomImage), userInfo: nil, repeats: true)
    }
    
    @objc func randomImage(){
        cardImageView.image = cards.randomElement() ?? UIImage(named: "AC")
    }

    @IBAction func stopButtonTapped(_ sender: Any) {
        timer.invalidate()
    }
    
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        startTimer()
    }

}
