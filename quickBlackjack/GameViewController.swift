//
//  ViewController.swift
//  quickBlackjack
//
//  Created by Danny Rivera on 4/10/19.
//  Copyright © 2019 Danny Rivera. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {

    var audioPlayer: AVAudioPlayer?
    var audioPlayer1: AVAudioPlayer?
    //goes from 1 to 6 (ie imageview placements)
    var place_id = 1 //starting bottomleft
    var value_id = 1
    var suit_id = 0
    var set = ""
    var suits = ["clubs", "hearts", "diamonds", "spades"]
    var bet = 0
    
    @IBOutlet weak var payoutText: UILabel!
    
    @IBOutlet weak var totalBetText: UILabel!
    
    @IBOutlet weak var TotalScoreText: UILabel!
    //imageView connections
    @IBOutlet weak var topRight: UIImageView!
    @IBOutlet weak var topMiddle: UIImageView!
    @IBOutlet weak var topLeft: UIImageView!
    @IBOutlet weak var bottomRight: UIImageView!
    @IBOutlet weak var bottomLeft: UIImageView!
    @IBOutlet weak var bottomMiddle: UIImageView!
    
    //button functions
    
    @IBAction func betPressed(_ sender: UIButton) {
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
        place_id = place_id + 1
        if(place_id > 6){place_id = 1}
        
        do {
            if let fileURL = Bundle.main.path(forResource: "card", ofType: "wav") {
                audioPlayer1 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
            } else {
                print("No file with specified name exists")
            }
        } catch let error {
            print("Can't play the audio file failed with an error \(error.localizedDescription)")
        }
        audioPlayer1?.play()
        
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            if let fileURL = Bundle.main.path(forResource: "casino", ofType: "mp3") {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
            } else {
                print("No file with specified name exists")
            }
        } catch let error {
            print("Can't play the audio file failed with an error \(error.localizedDescription)")
        }
        audioPlayer?.play()
        audioPlayer?.numberOfLoops = -1

        // Do any additional setup after loading the view.
        set = "png/" + String(value_id) + suits[0] + ".png"
        bottomLeft.image =  UIImage(named:"png/blank")
        bottomMiddle.image = UIImage(named:"png/blank")
        bottomRight.image = UIImage(named:"png/blank")
        
        topLeft.image = UIImage(named:"png/blank")
        topMiddle.image = UIImage(named:"png/blank")
        topRight.image = UIImage(named:"png/blank")
        payoutText.text = "0"
        TotalScoreText.text = "0"
    }
    
    func randomizer() -> String {
        value_id = Int.random(in: 1 ..< 14)
        suit_id = Int.random(in: 0 ..< 4)
        set = "png/" + String(value_id) + suits[suit_id] + ".png"
        
        return set
    }
   


}

