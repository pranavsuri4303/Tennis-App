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

class LoginViewController: UIViewController, GIDSignInDelegate {


	@IBOutlet weak var googlButton: GIDSignInButton!


    let delegate = UIApplication.shared.delegate as! AppDelegate



	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
		googlButton.style = GIDSignInButtonStyle(rawValue: 1)!
	}

	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
		if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let auth = user.authentication else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        Auth.auth().signIn(with: credentials) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("LoginSuccess")
            }
        }
	}

	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.setNavigationBarHidden(false, animated: animated)
	}



}
