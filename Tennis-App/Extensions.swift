//
//  Extensions.swift
//  Tennis-App
//
//  Created by Pranav  Suri on 16/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD



extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
		
    }
	func showIndicator(withTitle title: String, and Description:String) {
	   let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
	   Indicator.label.text = title
	   Indicator.isUserInteractionEnabled = false
	   Indicator.detailsLabel.text = Description
	   Indicator.show(animated: true)
	}
	func hideIndicator() {
	   MBProgressHUD.hide(for: self.view, animated: true)
	}
}
extension UITextField {

    func setInputViewDatePicker(target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .date //2
        self.inputView = datePicker //3

        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }


    @objc func tapCancel() {
        self.resignFirstResponder()
    }

}


