//
//  CommunityViewController.swift
//  Tennis-App
//
//  Created by Pranav  Suri on 5/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class StringViewController: UIViewController {
	let db = Firestore.firestore()

	@IBOutlet weak var TableView: UITableView!
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

	}

	@IBAction func addString(_ sender: Any) {
	}

}


