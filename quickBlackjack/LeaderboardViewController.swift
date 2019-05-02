//
//  LeaderboardViewController.swift
//  quickBlackjack
//
//  Created by Danny Rivera on 5/1/19.
//  Copyright © 2019 Danny Rivera. All rights reserved.
//

import UIKit

class LeaderboardViewController: Swipe , UITableViewDelegate, UITableViewDataSource{
    
    let list = ["surferdude22                               12345", "rpgplayer89                                  9999", "xding101                                        1000", "cusekid11                                       500"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
