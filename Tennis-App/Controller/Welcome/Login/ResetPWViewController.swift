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
import MBProgressHUD


class ResetPWViewController: UIViewController {

	@IBOutlet weak var emailField: UITextField!
	override func viewDidLoad() {
		hideKeyboardWhenTappedAround()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	@IBAction func resetPWPressed(_ sender: UIButton) {
        self.showIndicator(withTitle: "Please wait...", and: "Sending email.")
		Auth.auth().sendPasswordReset(withEmail: emailField.text!) { (err) in
			if err != nil{
                self.hideIndicator()
				ProgressHUD.showError(err?.localizedDescription)
			} else{
                self.hideIndicator()
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
