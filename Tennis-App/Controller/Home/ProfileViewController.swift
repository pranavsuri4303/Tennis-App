//
//  SecondViewController.swift
//  Tennis-App
//
//  Created by Pranav  Suri on 5/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UTRManagerDelegate {

	var utrManager = UTRManager()

	func didUpdateUtrProfile(profile: Profile) {
		DispatchQueue.main.async {
			print(profile.name)
			print(profile.singles)
			print(profile.singlesStatus)
		}

	}

	func didFailWithError(error: Error!) {
		print(error)
	}

	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		utrManager.delegate = self
		utrManager.fetchProfile(withID: "1631587")


	}


}

