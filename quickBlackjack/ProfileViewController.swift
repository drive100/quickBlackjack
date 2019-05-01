//
//  ProfileViewController.swift
//  quickBlackjack
//
//  Created by Danny Rivera on 5/1/19.
//  Copyright © 2019 Danny Rivera. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    //editable fields
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    
    //user image
    @IBOutlet weak var userImage: UIImageView!
    
    //label
    @IBOutlet weak var username: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: Any) {
    }
    
    @IBAction func logOutPressed(_ sender: UIButton) {
    }
    
}
