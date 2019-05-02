//
//  AccountViewController.swift
//  quickBlackjack
//
//  Created by Danny Rivera on 4/16/19.
//  Copyright © 2019 Danny Rivera. All rights reserved.
//

import UIKit
import AVFoundation

class SettingsViewController: UIViewController{

    var click = false
    @IBOutlet weak var musicSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        musicSwitch.isOn = false
        
        // Do any additional setup after loading the view.
    }
    @IBAction func switchClicked(_ sender: Any) {
        if (!click){
            music.audioPlayer?.numberOfLoops = 0
            music.audioPlayer?.stop()
        }else if (click){
            music.audioPlayer?.numberOfLoops = -1
            music.audioPlayer?.play()
        }
        click = !click

    }
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)

    }
    

}
