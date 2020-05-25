//
//  AdditionalInfoViewController.swift
//  Tennis-App
//
//  Created by Pranav  Suri on 15/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import FirebaseAuth
import Firebase
import MBProgressHUD
import ProgressHUD

class AdditionalInfoViewController: UIViewController {
    
    
    var fName = ""
    var email = ""
    var lname = ""
    
    // Text Field Outlets
    @IBOutlet weak var FNameField: SkyFloatingLabelTextField!
    @IBOutlet weak var LNameField: SkyFloatingLabelTextField!
    @IBOutlet weak var YOBField: SkyFloatingLabelTextField!
    @IBOutlet weak var SexField: SkyFloatingLabelTextField!
    @IBOutlet weak var NationalityField: SkyFloatingLabelTextField!
    
    // Naionality Picker
    let nationalities = Nationalities()
    let nationalityPicker = UIPickerView()

    // Sex Picker
    let sex = Gender()
    let sexPicker = UIPickerView()

    override func viewDidLoad() {
        
        // Nationality Picker Setup
        NationalityField.inputView = nationalityPicker
        nationalityPicker.delegate = self

        // Sex Picker Setup
        SexField.inputView = sexPicker
        sexPicker.delegate = self
        
        super.viewDidLoad()
		self.navigationItem.hidesBackButton = true

        // Do any additional setup after loading the view.
    }
    

    @IBAction func DonePressed(_ sender: UIButton) {
        if (FNameField.text == "" ||
            LNameField.text == "" ||
            YOBField.text == "" ||
            SexField.text == "" ||
            NationalityField.text == ""){
            ProgressHUD.showError("Please complete all fields.")
        } else{
            let curUser = Auth.auth().currentUser
            let db = Firestore.firestore()
            let userData: [String: Any] = [
                "Name": [self.FNameField.text!.uppercased(),
                         self.LNameField.text!.uppercased()],
                "YOB": self.YOBField.text!,
                "Sex": self.SexField.text!,
                "Nationality": self.NationalityField.text!,
                "Email": curUser!.email!,
                "UID": curUser!.uid
            ]
            let stringData: [String:Any] = ["stringHistory": []]
            db.collection("users").document((curUser?.uid)!).setData(userData) { (error) in
                if error != nil{
                    print(error?.localizedDescription as Any)
                } else{
                    self.hideIndicator()
                    ProgressHUD.showSuccess("Registered")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        self.performSegue(withIdentifier: "ExtraToHome", sender: self)
                    }
                }
            }
            db.collection("strings").document((curUser?.uid)!).setData(stringData)
            
        }
        
    }
    

}

extension AdditionalInfoViewController: UIPickerViewDelegate, UIPickerViewDataSource{

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
