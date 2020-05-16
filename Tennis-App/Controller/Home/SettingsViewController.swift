//
//  SettingsViewController.swift
//  Tennis-App
//
//  Created by Pranav  Suri on 15/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	@IBAction func LogoutPressed(_ sender: UIBarButtonItem) {
		do{
			try Auth.auth().signOut()
		}catch{
			print("Can't log out")
		}
		let story = UIStoryboard(name: "Main", bundle: nil)
		let vc = story.instantiateViewController(identifier: "welcome") as UIViewController
		vc.modalPresentationStyle = .fullScreen
		present(vc,animated: true,completion: nil)
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
