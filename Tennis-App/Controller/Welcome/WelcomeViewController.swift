//
//  WelcomeViewController.swift
//  Tennis-App
//
//  Created by Pranav  Suri on 5/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

	@IBOutlet weak var signinButton: UIButton!
	@IBOutlet weak var registerButton: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
		signinButton.layer.cornerRadius = 10
		registerButton.layer.cornerRadius = 10
	}


}
