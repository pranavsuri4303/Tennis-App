//
//  WelcomeViewController.swift
//  Tennis-App
//
//  Created by Pranav  Suri on 5/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

	@IBOutlet weak var signInButton: UIButton!
	@IBOutlet weak var registerButton: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()

		// Make the buttons rounded.
		signInButton.layer.cornerRadius = 10
		registerButton.layer.cornerRadius = 10

	}
	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.setNavigationBarHidden(true, animated: animated)
	}


}
