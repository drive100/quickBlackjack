//
//  ProfileViewController.swift
//  quickBlackjack
//
//  Created by Danny Rivera on 5/1/19.
//  Copyright © 2019 Danny Rivera. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController{
    
    
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
    
    @IBAction func fnameEdit(_ sender: UITextField) {
        
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: Any) {
        let alert = UIAlertController(title: "Info Saved!", message: "Saved successfully", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(action1)
        present(alert,animated: true, completion: nil)
    }
    
    @IBAction func logOutPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Yes", style: .default)
        let action2 = UIAlertAction(title: "No", style: .destructive)

        
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert,animated: true, completion: nil)
    }
    
}
