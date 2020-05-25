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
	var ErrorMessage = ""


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
	let sex = Gender()
	let sexPicker = UIPickerView()


	override func viewDidLoad() {
		super.viewDidLoad()
//        self.navigationItem.hidesBackButton = true
		self.hideKeyboardWhenTappedAround()
		
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
		ErrorMessage = ""
			errorDisplayer(textField: FNameField)
			errorDisplayer(textField: LNameField)
			errorDisplayer(textField: YOBField)
			errorDisplayer(textField: SexField)
			errorDisplayer(textField: NationalityField)
			errorDisplayer(textField: EmailField)
			errorDisplayer(textField: PasswordField)
			errorDisplayer(textField: RPasswordField)
			if errors.contains(true){
				ProgressHUD.showError(ErrorMessage)
			} else {
				showIndicator(withTitle: "Creating User", and: "")
				Auth.auth().createUser(withEmail: EmailField.text!, password: PasswordField.text!) { (result, err) in
					if err != nil{
						self.hideIndicator()
						print(err?.localizedDescription as Any)
					} else {
						let db = Firestore.firestore()
						let userData: [String: Any] = [
							"Name": [self.FNameField.text!.uppercased(),
									 self.LNameField.text!.uppercased()],
							"YOB": self.YOBField.text!,
							"Sex": self.SexField.text!,
							"Nationality": self.NationalityField.text!,
							"Email": result?.user.email as Any,
							"UID": result!.user.uid
						]
						let stringData: [String:Any] = ["stringHistory": []]
						db.collection("users").document((result?.user.uid)!).setData(userData) { (error) in
							if error != nil{
								print(error?.localizedDescription as Any)
							} else{
								self.hideIndicator()
								ProgressHUD.showSuccess("Registered")
								DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
									self.performSegue(withIdentifier: "RegisterToUTR", sender: self)
								}
							}
						}
						db.collection("strings").document((result?.user.uid)!).setData(stringData)
					}
				}
			}
		}
	func errorDisplayer(textField: UITextField){
		switch textField {

		case FNameField:
			if FNameField.text?.count == 0{
				ErrorMessage = ErrorMessage + "➤Please enter first name.\n"
				FNameField.errorMessage = "Please enter first name."
				errors[0] = true
			} else{
				FNameField.errorMessage = ""
				errors[0] = false
			}
		case LNameField:
			if LNameField.text?.count == 0{
				ErrorMessage = ErrorMessage + "➤Please enter Last Name.\n"
				LNameField.errorMessage = "Please enter Last Name."
				errors[1] = true
			} else{
				LNameField.errorMessage = ""
				errors[1] = false
			}
		case YOBField:
			if V.YOB.validate(YOBField.text!) != nil{
				ErrorMessage = ErrorMessage + "➤Invalid Year of Birth\n"
				YOBField.errorMessage = "Invalid Year of Birth"
				errors[2] = true
			} else{
				YOBField.errorMessage = ""
				errors[2] = false
			}
		case SexField:
			if SexField.text?.count == 0{
				ErrorMessage = ErrorMessage + "➤Please enter Sex.\n"
				SexField.errorMessage = "Please enter Sex."
				errors[3] = true
			} else{
				SexField.errorMessage = ""
				errors[3] = false
			}
		case NationalityField:
			if NationalityField.text?.count == 0{
				ErrorMessage = ErrorMessage + "➤Please enter Nationality.\n"
				NationalityField.errorMessage = "Please enter Nationality."
				errors[4] = true
			} else{
				NationalityField.errorMessage = ""
				errors[4] = false
			}
		case EmailField:
			if (EmailField.text?.count == 0) || !(V.isValidEmail((EmailField.text)!)){
				ErrorMessage = ErrorMessage + "➤Invalid Email\n"
				EmailField.errorMessage = "Invalid Email"
				errors[5] = true
			} else{
				EmailField.errorMessage = ""
				errors[5] = false
			}
		case PasswordField:
			if V.password.validate(PasswordField.text!) != nil{
				ErrorMessage = ErrorMessage + "➤Password: Alphanumeric & Min length 8\n"
				PasswordField.errorMessage = "Password: Alphanumeric & Min length 8"
				errors[6] = true
			} else{
				PasswordField.errorMessage = ""
				errors[6] = false
			}
		case RPasswordField:
			if RPasswordField.text != PasswordField.text || RPasswordField.text?.count == 0{
				ErrorMessage = ErrorMessage + "➤Passwords do not match.\n"
				RPasswordField.errorMessage = "Passwords do not match."
				errors[7] = true
			} else{
				RPasswordField.errorMessage = ""
				errors[7] = false
			}
		default:
			print("RIP")
		}
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
