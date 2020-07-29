//
//  LoginViewController.swift
//  Tennis-App
//
//  Created by Pranav  Suri on 5/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import ProgressHUD
import Navajo_Swift
import SkyFloatingLabelTextField

class LoginViewController: UIViewController, GIDSignInDelegate {

	@IBOutlet weak var EmailField: SkyFloatingLabelTextField!
    @IBOutlet weak var EmailImage: UIImageView!
    @IBOutlet weak var PasswordField: SkyFloatingLabelTextField!
    @IBOutlet weak var PasswordImage: UIImageView!
    
	@IBOutlet weak var googleButon: GIDSignInButton!


    let delegate = UIApplication.shared.delegate as! AppDelegate


	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.isNavigationBarHidden = false
		// Do any additional setup after loading the view.

        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
		googleButon.style = GIDSignInButtonStyle(rawValue: 1)!
		self.hideKeyboardWhenTappedAround()
        
	}

	@IBAction func signInPressed(_ sender: UIButton) {
		showIndicator(withTitle: "Logging in", and: "Please wait...")
		Auth.auth().signIn(withEmail: EmailField.text!, password: PasswordField.text!) { (result, error) in
			if error != nil{
				self.hideIndicator()
				ProgressHUD.showError("Invalid Login details")
			} else{
				self.hideIndicator()
				ProgressHUD.showSuccess("Logged in")
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
					self.performSegue(withIdentifier: "SignInToHome", sender: self)
				}
			}
		}
	}



	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
		showIndicator(withTitle: "Logging in", and: "Please wait...")
		if let error = error {
			self.hideIndicator()
			print(error.localizedDescription)
			return
		}
		guard let auth = user.authentication else { return }
		let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
		Auth.auth().signIn(with: credentials) { (authResult, error) in
			if let error = error {
				self.hideIndicator()
				print(error.localizedDescription)
				ProgressHUD.showError("Error Logging in")
			} else {
                if ((authResult?.additionalUserInfo?.isNewUser) == true){
                    self.hideIndicator()
                    ProgressHUD.showSuccess("Logged in")
                    self.performSegue(withIdentifier: "SignInToExtra", sender: self)
                } else{
                    self.hideIndicator()
                    ProgressHUD.showSuccess("Logged in")
                    print("LoginSuccess")
                    let story = UIStoryboard(name: "Home", bundle: nil)
                    let vc = story.instantiateViewController(identifier: "tab") as UITabBarController
                    self.present(vc,animated: true,completion: nil)
                }
			}
		}
	}

	override func viewWillAppear(_ animated: Bool) {
	}
}

