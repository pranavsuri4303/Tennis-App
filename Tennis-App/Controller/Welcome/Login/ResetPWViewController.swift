//
//  ResetPW.swift
//  Tennis-App
//
//  Created by Pranav  Suri on 15/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import ProgressHUD


class ResetPWViewController: UIViewController {

	@IBOutlet weak var emailField: UITextField!
	override func viewDidLoad() {
		hideKeyboardWhenTappedAround()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	@IBAction func resetPWPressed(_ sender: UIButton) {
		Auth.auth().sendPasswordReset(withEmail: emailField.text!) { (err) in
			if err != nil{
				ProgressHUD.showError(err?.localizedDescription)
			} else{
				ProgressHUD.showSuccess("An email has been sent with instructions to reset your password.")
			}
		}
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
