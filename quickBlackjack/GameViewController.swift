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
    var id = 1
    var suit = ""
    var set = ""
    var suits = ["clubs", "hearts", "diamonds", "spades"]
    
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
    }
    
    @IBAction func minusPressed(_ sender: UIButton) {
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
        set = "png/" + String(id) + suits[0] + ".png"
        bottomLeft.image =  UIImage(named:set)
        bottomMiddle.image = UIImage(named:"png/blank")
        bottomRight.image = UIImage(named:"png/blank")
        
        topLeft.image = UIImage(named:"png/blank")
        topMiddle.image = UIImage(named:"png/blank")
        topRight.image = UIImage(named:"png/blank")
        payoutText.text = "0"
        TotalScoreText.text = "0"
    }
    
    func randomizer(){
        id = Int.random(in: 1 ..< 14)
        set = "png/" + String(id) + suits[0] + ".png"
        
    }
   


}

