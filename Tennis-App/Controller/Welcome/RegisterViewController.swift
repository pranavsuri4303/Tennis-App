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

class RegisterViewController: UIViewController {


	// Personal Details
	@IBOutlet weak var FNameField: UITextField!
	@IBOutlet weak var LNameField: UITextField!
	@IBOutlet weak var YOBField: UITextField!
	@IBOutlet weak var SexField: UITextField!
	@IBOutlet weak var NationalityField: UITextField!

	// Login Details
	@IBOutlet weak var EmailField: UITextField!
	@IBOutlet weak var PasswordField: UITextField!
	@IBOutlet weak var RPasswordField: UITextField!

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
		Auth.auth().createUser(withEmail: EmailField.text!, password: PasswordField.text!) { (result, err) in
			if err != nil{
				print(err?.localizedDescription as Any)
			} else {
				let db = Firestore.firestore()
				let data = [
					"Name": "\(self.FNameField.text!) \(self.LNameField.text!)",
					"YOB": self.YOBField.text!,
					"Sex": self.SexField.text!,
					"Nationality": self.NationalityField.text!,
					"Email": result!.user.email!,
					]
				db.collection("users").document((result?.user.uid)!).setData(data) { (error) in
					if error != nil{
						print(error?.localizedDescription)
					}
				}
			}
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
	func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
		switch textField {
		case FNameField:
			print(FNameField.text as Any)
		case LNameField:
			print(LNameField.text as Any)
		case YOBField:
			print(YOBField.text as Any)
		case SexField:
			print(SexField.text as Any)
		case NationalityField:
			print(NationalityField.text as Any)
		case EmailField:
			print(EmailField.text as Any)
		case PasswordField:
			print(PasswordField.text as Any)
		case RPasswordField:
			print(RPasswordField.text as Any)
		default:
			print("\(FNameField.text ?? "") \(LNameField.text ?? "")")
		}
	}
}
