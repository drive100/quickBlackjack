//
//  ViewController.swift
//  quickBlackjack
//
//  Created by Danny Rivera on 4/10/19.
//  Copyright © 2019 Danny Rivera. All rights reserved.
//

import UIKit
import AVFoundation

struct music {
    static var audioPlayer: AVAudioPlayer?
    static var audioPlayer1: AVAudioPlayer?
    
}

class GameViewController: Swipe {
    
    
    //variables
    //goes from 1 to 6 (ie imageview placements)
    var place_id = 0 //starting bottomleft
    var value_id = 1
    var suit_id = 0
    var set = ""
    var suits = ["clubs", "hearts", "diamonds", "spades"]
    var bet = 0
    var totalCardVal = 0
    var over21 = false
    var equal21 = false
    var totalWinnings = 0
    var won = false
    var tie = false
    
    //labels
    @IBOutlet weak var totalBetText: UILabel!
    @IBOutlet weak var TotalScoreText: UILabel!
    @IBOutlet weak var totalValue: UILabel!
    @IBOutlet weak var payoutText: UILabel!
    
    //imageView connections
    @IBOutlet weak var topRight: UIImageView!
    @IBOutlet weak var topMiddle: UIImageView!
    @IBOutlet weak var topLeft: UIImageView!
    @IBOutlet weak var bottomRight: UIImageView!
    @IBOutlet weak var bottomLeft: UIImageView!
    @IBOutlet weak var bottomMiddle: UIImageView!
    
    //button functions
    @IBAction func postPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Post Score?", message: "Are you done playing and want to post your score on the leaderboard?", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Yes", style: .default)
        //{action in self.reset()}
        
        let action2 =  UIAlertAction(title: "No", style: .default)
        
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert,animated: true, completion: nil)
    }
    
  
    @IBAction func stayPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Stay?", message: "Are you sure you want to stay with this hand?", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Yes", style: .default)
        {action in self.dealersHand()}
        
        let action2 =  UIAlertAction(title: "No", style: .default)
        
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert,animated: true, completion: nil)
    }
    @IBAction func betPressed(_ sender: UIButton) {
        if (Int(totalBetText.text!) == 0){
            let alert = UIAlertController(title: "No bet placed!", message: "You need to set your bet before playing next card!", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Ok", style: .default)
            //{action in self.calculateWinLoss()}
            
            alert.addAction(action1)
            present(alert,animated: true, completion: nil)
        }else{
        let newCard = randomizer()
        switch(place_id){
        case 1:
            bottomLeft.image =  UIImage(named:newCard)
            break
        case 2:
            bottomMiddle.image =  UIImage(named:newCard)
            break
        case 3:
            bottomRight.image = UIImage(named:newCard)
            break
        case 4:
            topLeft.image = UIImage(named:newCard)
            break
        case 5:
            topMiddle.image = UIImage(named:newCard)
            break
        case 6:
            topRight.image = UIImage(named:newCard)
            break
        default:
            break
        }
       
        
        do {
            if let fileURL = Bundle.main.path(forResource: "card", ofType: "wav") {
                music.audioPlayer1 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
            } else {
                print("No file with specified name exists")
            }
        } catch let error {
            print("Can't play the audio file failed with an error \(error.localizedDescription)")
        }
        music.audioPlayer1?.play()
        
        if (over21){
        let alert = UIAlertController(title: "Game Over", message: "You went over 21! Click ok to start a new game", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Ok", style: .default)
        {action in self.calculateWinLoss()}
        
        alert.addAction(action1)
        present(alert,animated: true, completion: nil)
        
        } else if (equal21){
            let alert = UIAlertController(title: "Blackjack!", message: "You won! You got 21! Won 3x your bet", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Ok", style: .default)
            {action in self.calculateWinLoss()}
            
            alert.addAction(action1)
            present(alert,animated: true, completion: nil)
            
        }
        }
    }
    
    @IBAction func plusPressed(_ sender: UIButton) {
        bet = bet + 1
        totalBetText.text = String(bet)
    }
    
    @IBAction func minusPressed(_ sender: UIButton) {
        bet = bet - 1
        if bet < 0 {bet = 0}
        totalBetText.text = String(bet)
    }

    
    @IBAction func FoldButtonPressed(_ sender: Any) {
        won = false
        let alert = UIAlertController(title: "Fold?", message: "Are you sure you want to fold this game?", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Yes", style: .default)
        {action in self.calculateWinLoss()}
        
        let action2 =  UIAlertAction(title: "No", style: .default)
        
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert,animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            if let fileURL = Bundle.main.path(forResource: "casino", ofType: "mp3") {
                music.audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
            } else {
                print("No file with specified name exists")
            }
        } catch let error {
            print("Can't play the audio file failed with an error \(error.localizedDescription)")
        }
        music.audioPlayer?.play()
        music.audioPlayer?.numberOfLoops = -1

        totalValue.text =  "0"
        payoutText.text = "0"
        TotalScoreText.text = "0"
        totalBetText.text = "0"
        
        let tmp = randomizer()
        bottomLeft.image =  UIImage(named:tmp)
        bottomMiddle.image = UIImage(named:"png/blank")
        bottomRight.image = UIImage(named:"png/blank")
        
        topLeft.image = UIImage(named:"png/blank")
        topMiddle.image = UIImage(named:"png/blank")
        topRight.image = UIImage(named:"png/blank")
        
    }
    
    func randomizer() -> String {
        place_id = place_id + 1
        if(place_id > 6){place_id = 1}
        value_id = Int.random(in: 1 ..< 14)
        suit_id = Int.random(in: 0 ..< 4)
        set = "png/" + String(value_id) + suits[suit_id] + ".png"
        
        var tmp = value_id
        if(tmp >= 10){ tmp = 10}
        totalCardVal = totalCardVal + tmp
        totalValue.text = String(totalCardVal)

        if (totalCardVal > 21){over21 = true}
        else if (totalCardVal == 21){equal21 = true}
        return set
    }
    
    func dealersHand(){
        let val = Int.random(in: 15 ..< 30)
        if (val == totalCardVal){
            tie = true
            won = true
            let alert = UIAlertController(title: "Tie!", message: "Your card value equals the dealers hand! \nDealers hand \(val)", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Ok", style: .default)
            {action in self.calculateWinLoss()}
          
            alert.addAction(action1)
            present(alert,animated: true, completion: nil)
        }
        else if (val > totalCardVal && val < 21){
            let alert = UIAlertController(title: "You Lost!", message: "Your card value is less the dealers hand!\nDealers hand: \(val)", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Ok", style: .default)
            {action in self.calculateWinLoss()}
            
            alert.addAction(action1)
            present(alert,animated: true, completion: nil)
        }
        else if (val < totalCardVal && val < 21){
            won = true
            let alert = UIAlertController(title: "You Won!", message: "Your card value is greater than the dealers hand! \nDealers hand: \(val)", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Ok", style: .default)
            {action in self.calculateWinLoss()}
            
            alert.addAction(action1)
            present(alert,animated: true, completion: nil)
        }
        else if (val > 21){
            won = true
            let alert = UIAlertController(title: "You Won!", message: "The Dealer went over 21! \nDealers hand: \(val)", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Ok", style: .default)
            {action in self.calculateWinLoss()}
            
            alert.addAction(action1)
            present(alert,animated: true, completion: nil)
        }
    }
    
    func calculateWinLoss(){
        if ((over21 || !won) && !equal21){
            totalWinnings = totalWinnings - bet
            payoutText.text = String((-totalWinnings))
            TotalScoreText.text = String(totalWinnings)
        }
        else if (equal21){
            totalWinnings = totalWinnings + (3*bet)
            payoutText.text = String(totalWinnings)
            TotalScoreText.text = String(totalWinnings)
        }
        else if (won && !tie){
            totalWinnings = totalWinnings + (2*bet)
            payoutText.text = String(totalWinnings)
            TotalScoreText.text = String(totalWinnings)
        }
        else if (tie){
            totalWinnings = totalWinnings + (bet)
            payoutText.text = String(totalWinnings)
            TotalScoreText.text = String(totalWinnings)
        }
        if (totalWinnings < 0) {TotalScoreText.text = "0"}


        reset()
    }

    func reset(){
        bet = 0
        won = false
        tie = false
        over21 = false
        equal21 = false
        place_id = 0
        totalCardVal=0
        totalValue.text = "0"
        let tmp = randomizer()
        bottomLeft.image =  UIImage(named:tmp)
        bottomMiddle.image = UIImage(named:"png/blank")
        bottomRight.image = UIImage(named:"png/blank")
        
        topLeft.image = UIImage(named:"png/blank")
        topMiddle.image = UIImage(named:"png/blank")
        topRight.image = UIImage(named:"png/blank")
        totalBetText.text = "0"

        
    }
}

