//
//  WelcomeViewController.swift
//  Tennis-App
//
//  Created by Pranav  Suri on 5/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import UIKit
import FirebaseAuth

class WelcomeViewController: UIViewController {

	@IBOutlet weak var signInButton: UIButton!
	@IBOutlet weak var registerButton: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()

        if Auth.auth().currentUser != nil{

            print("user logged in")
            let story = UIStoryboard(name: "Home", bundle: nil)

            let vc = story.instantiateViewController(identifier: "tab") as UITabBarController
            present(vc,animated: true,completion: nil)
        }
             //or stay here
        
        
        
		// Make the buttons rounded.
		signInButton.layer.cornerRadius = 10
		registerButton.layer.cornerRadius = 10

	}


}
