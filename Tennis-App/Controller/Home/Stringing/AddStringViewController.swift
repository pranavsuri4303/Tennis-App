//
//  AddStringViewController.swift
//  Tennis-App
//
//  Created by Pranav  Suri on 16/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Firebase
import ProgressHUD

class AddStringViewController: UIViewController {

	let datePicker = UIDatePicker()

	@IBOutlet weak var mainPicker: UIStepper!
	@IBOutlet weak var crossPicker: UIStepper!
	@IBOutlet weak var addStringButton: UIBarButtonItem!
	@IBOutlet weak var Steppers: UIStepper!

	@IBOutlet weak var RacketNameField: SkyFloatingLabelTextField!
	@IBOutlet weak var BrandField: SkyFloatingLabelTextField!
	@IBOutlet weak var StringNameField: SkyFloatingLabelTextField!
	@IBOutlet weak var DateField: SkyFloatingLabelTextField!

	@IBOutlet weak var CrossLabel: UILabel!
	@IBOutlet weak var MainsLabel: UILabel!
	override func viewDidLoad() {
		super.viewDidLoad()
		Steppers.value = 20
		datePicker.datePickerMode = .date
		DateField.inputView = datePicker
		self.hideKeyboardWhenTappedAround()
		datePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
	}
	@objc func datePickerChanged(picker: UIDatePicker) {
		let df = DateFormatter()
		df.dateStyle = .medium
		let date = df.string(from: picker.date)
		DateField.text = date
	}
	
	@IBAction func MainsStepperChanged(_ sender: UIStepper) {
		MainsLabel.text = String(format: "%.0f", sender.value)
	}
	@IBAction func CrossStepperChanged(_ sender: UIStepper) {
		CrossLabel.text = String(format: "%.0f", sender.value)
	}

	@IBAction func AddStringPressed(_ sender: UIBarButtonItem) {
		addStringButton.isEnabled = false
		if noFieldEmpty(){
			showIndicator(withTitle: "Adding stringing entry to database.", and: "")
			let stringData : [String:Any] = ["racket": self.RacketNameField.text!,
											 "stringBrand": self.BrandField.text!,
											 "stringName": self.StringNameField.text!,
											 "mainsTension": self.MainsLabel.text!,
											 "crossTension": self.CrossLabel.text!,
											 "date": self.DateField.text!,
											 "created": Timestamp.init()]

			let db = Firestore.firestore()
			let uid = (Auth.auth().currentUser?.uid)!
			let stringHistoryRef = db.collection("strings").document(uid)
			stringHistoryRef.updateData(["stringHistory": FieldValue.arrayUnion([stringData])]) { (err) in
				if err != nil{
					self.hideIndicator()
					self.clearTextFields()
					self.addStringButton.isEnabled = true
					ProgressHUD.showError(err?.localizedDescription)

				} else{
					self.hideIndicator()
					self.clearTextFields()
					self.addStringButton.isEnabled = true
					ProgressHUD.showSuccess("Stringing entry added.")
				}
			}
		} else{
			self.hideIndicator()
			self.addStringButton.isEnabled = true
			ProgressHUD.showError("Please complete all fields.")
		}

	}
	// Check for empty field.
	func noFieldEmpty()->Bool{
		if (self.RacketNameField.text == "" ||
			self.BrandField.text == "" ||
			self.StringNameField.text == "" ||
			self.DateField.text == ""){
			return false
		} else{
			return true
		}
	}
	//Clear textfields after entry has been made.
	func clearTextFields(){
		self.RacketNameField.text = ""
		self.BrandField.text = ""
		self.StringNameField.text = ""
		self.DateField.text = ""
		self.MainsLabel.text = "20"
		self.CrossLabel.text = "20"
		self.mainPicker.value = 20
		self.crossPicker.value = 20

	}

}



