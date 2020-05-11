//
//  RegisterViewController.swift
//  Tennis-App
//
//  Created by Pranav  Suri on 5/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import ProgressHUD
import Navajo_Swift
import SkyFloatingLabelTextField

class RegisterViewController: UIViewController {

	let V = Validators()

	let textFields = ["FName",
					  "LName",
					  "YOB",
					  "Sex",
					  "Nationality",
					  "Email",
					  "Password",
					  "RPassword"
	]

	var errors = [true,
				  true,
				  true,
				  true,
				  true,
				  true,
				  true,
				  true
	]

	// Personal Details
	@IBOutlet weak var FNameField: SkyFloatingLabelTextField!
	@IBOutlet weak var LNameField: SkyFloatingLabelTextField!
	@IBOutlet weak var YOBField: SkyFloatingLabelTextField!
	@IBOutlet weak var SexField: SkyFloatingLabelTextField!
	@IBOutlet weak var NationalityField: SkyFloatingLabelTextField!

	// Login Details
	@IBOutlet weak var EmailField: SkyFloatingLabelTextField!
	@IBOutlet weak var PasswordField: SkyFloatingLabelTextField!
	@IBOutlet weak var RPasswordField: SkyFloatingLabelTextField!

	// Naionality Picker
	let nationalities = Nationalities()
	let nationalityPicker = UIPickerView()

	// Sex Picker
	let sex = Sex()
	let sexPicker = UIPickerView()


	override func viewDidLoad() {
		super.viewDidLoad()
		// Nationality Picker Setup
		NationalityField.inputView = nationalityPicker
		nationalityPicker.delegate = self

		// Sex Picker Setup
		SexField.inputView = sexPicker
		sexPicker.delegate = self

		// Text Field Delegation
		FNameField.delegate = self
		LNameField.delegate = self
		YOBField.delegate = self
		SexField.delegate = self
		NationalityField.delegate = self
		EmailField.delegate = self
		PasswordField.delegate = self
		RPasswordField.delegate = self
	}

	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.setNavigationBarHidden(false, animated: animated)
	}

	@IBAction func registerPressed(_ sender: UIButton) {
		var errFields = [""]
		if (RPasswordField.text != PasswordField.text) || (RPasswordField.text?.count == 0){
			errors[7] = true
		}else{
			errors[7] = false
		}
		for index in 0...7{
			if errors[index]{
				errFields.append(textFields[index])
			}
			if index == 7 {
				errFields.remove(at: 0)
			}
		}
		print(errFields)
		if errFields.count == 1{
			print(errFields)
		}

//		Auth.auth().createUser(withEmail: EmailField.text!, password: PasswordField.text!) { (result, err) in
//			if err != nil{
//				print(err?.localizedDescription as Any)
//			} else {
//				let db = Firestore.firestore()
//				let data = [
//					"Name": "\(self.FNameField.text!) \(self.LNameField.text!)",
//					"YOB": self.YOBField.text!,
//					"Sex": self.SexField.text!,
//					"Nationality": self.NationalityField.text!,
//					"Email": result?.user.email,
//					"UID": result!.user.uid
//				]
//				db.collection("users").document((result?.user.email)!).setData(data) { (error) in
//					if error != nil{
//						print(error?.localizedDescription)
//					} else{
//						self.performSegue(withIdentifier: "RegisterToHome", sender: self)
//					}
//				}
//			}
//		}
	}

}

//MARK: Extensions
//MARK: Nationality Picker and Sex Picker Delegation
extension RegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource{

	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		switch pickerView {
		case nationalityPicker:
			return nationalities.list.count
		case sexPicker:
			return sex.type.count
		default:
			return 0
		}
	}
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		switch pickerView {
		case nationalityPicker:
			return nationalities.list[row]
		case sexPicker:
			return sex.type[row]
		default:
			return ""
		}
	}
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		switch pickerView {
		case nationalityPicker:
			NationalityField.text = nationalities.list[row]
		case sexPicker:
			SexField.text = sex.type[row]
		default:
			return
		}
	}
}

//MARK: Text Field Delegation
extension RegisterViewController: UITextFieldDelegate{

	func errorAssigner(_ textField: UITextField){
		switch textField {
		case FNameField:
			if FNameField.text?.count == 0{
				print("Invalid Fname")
				self.errors[0] = true
			} else{
				print("Valid FName")
				self.errors[0] = false
			}
		case LNameField:
			if LNameField.text?.count == 0{
				print("Invalid LName")
				self.errors[1] = true
			} else{
				print("Valid LName")
				self.errors[1] = false
			}
		case YOBField:
			if V.YOB.validate(YOBField.text!) != nil{
				print("Invalid YOB")
				self.errors[2] = true
			} else{
				print("Valid YOB")
				self.errors[2] = false
			}
		case SexField:
			if SexField.text?.count == 0{
				print("Invalid Sex")
				self.errors[3] = true
			} else{
				print("Valid Sex")
				self.errors[3] = false
			}
		case NationalityField:
			if NationalityField.text?.count == 0{
				print("Invalid Nationality")
				self.errors[4] = true
			} else{
				print("Valid Nationality")
				self.errors[4] = false
			}
		case EmailField:
			if (EmailField.text?.count == 0) || !(V.isValidEmail((EmailField.text)!)){
				print("Invalid Email")
				self.errors[5] = true
			} else{
				print("Valid Email")
				self.errors[5] = false
			}
		case PasswordField:
			if V.password.validate(PasswordField.text!) != nil{
				print("Invalid Password")
				self.errors[6] = true
			} else{
				print("Valid Password")
				self.errors[6] = false
			}
		default:
			print("RIP")
		}
	}
	func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
		self.errorAssigner(textField)
	}
}
