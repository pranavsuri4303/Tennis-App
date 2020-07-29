//
//  ConnectUTR.swift
//  Tennis-App
//
//  Created by Pranav  Suri on 15/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import UIKit
import ProgressHUD

class ConnectUTR: UIViewController {
    


	@IBOutlet weak var searchTextField: UISearchBar!
    
    
	override func viewDidLoad() {
        
		self.hideKeyboardWhenTappedAround()
        super.viewDidLoad()
		self.navigationItem.hidesBackButton = true

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }

	@IBAction func skipPressed(_ sender: UIBarButtonItem) {
		self.performSegue(withIdentifier: "UTRToHome", sender: self)
	}




    

}
