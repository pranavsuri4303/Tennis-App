//
//  MatchViewController.swift
//  Tennis-App
//
//  Created by Pranav  Suri on 5/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController{
    
    
    // Data for Picker View
    let noOfGamesData = ["","4","6","8"]
    let TB = ["","7","10"]
    let TBat0 = ["","3-3","4-4","5-5","6-6"]
    let TBat1 = ["","5-5","6-6","7-7","8-8"]
    let TBat2 = ["","7-7","8-8","9-9","10-10"]
    let deuceData = ["","Deuce","Sudden Death","1 Deuce Only"]
    
    
    
    // Text Fields
    @IBOutlet weak var noOfGamesField: UITextField!
    @IBOutlet weak var deuceField: UITextField!
    @IBOutlet weak var TBWithinSetScoreField: UITextField!
    @IBOutlet weak var TBWithinSetPointsField: UITextField!
    @IBOutlet weak var TBFinalSetField: UITextField!
    
    @IBOutlet weak var finalSetStack: UIStackView!
    @IBOutlet weak var TBWithinSetStack: UIStackView!
    
    
    
    // Picker Views
    let gamesPicker = UIPickerView()
    let deucePicker = UIPickerView()
    let TBWithinSetPicker = UIPickerView()
    let TBWithinSetPointsPicker = UIPickerView()
    let TBFinalSetPicker = UIPickerView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noOfGamesField.layer.borderColor = CGColor(srgbRed: 0.831, green: 0.953, blue: 0.937, alpha: 1.0)
        finalSetStack.isHidden = true
        // Picker View Delegation
        gamesPicker.delegate = self
        deucePicker.delegate = self
        TBWithinSetPicker.delegate = self
        TBWithinSetPointsPicker.delegate = self
        TBFinalSetPicker.delegate = self
        
        
        
        // Text field Delegation
        noOfGamesField.delegate = self
        deuceField.delegate = self
        TBWithinSetScoreField.delegate = self
        TBWithinSetPointsField.delegate = self
        TBFinalSetField.delegate = self
        
        // Set the Input View to Picker
        noOfGamesField.inputView = gamesPicker
        deuceField.inputView = deucePicker
        TBWithinSetScoreField.inputView = TBWithinSetPicker
        TBWithinSetPointsField.inputView = TBWithinSetPointsPicker
        TBFinalSetField.inputView = TBFinalSetPicker
        
        
    }
    
    @IBAction func noOfSets(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UIStackView.animate(withDuration: 0.5) {
                self.finalSetStack.isHidden = true
            }
        case 1:
            UIStackView.animate(withDuration: 0.5) {
                self.finalSetStack.isHidden = false
            }
        default:
            return
        }
    }
    @IBAction func TBWithinSet(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UIStackView.animate(withDuration: 0.5) {
                self.TBWithinSetStack.isHidden = false
            }
            
        case 1:
            UIStackView.animate(withDuration: 0.5) {
                self.TBWithinSetStack.isHidden = true
                self.TBWithinSetScoreField.text = nil
                self.TBWithinSetPointsField.text = nil
            }
        default:
            return
        }
    }
    
    @IBAction func TBFinalSet(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UITextField.animate(withDuration: 0.5) {
                self.TBFinalSetField.isHidden = false
            }
        case 1:
            UITextField.animate(withDuration: 0.5) {
                self.TBFinalSetField.isHidden = true
                self.TBFinalSetField.text = nil
            }
        default:
            return
        }
    }
    @IBAction func DonePressed(_ sender: Any) {
        self.performSegue(withIdentifier: "NewMatchToPlayers", sender: self)
    }
}

extension MatchViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch UITextField() {
        case self.noOfGamesField:
            print(self.noOfGamesField.text!)
        case self.deuceField:
            print(self.deuceField.text!)
        case self.TBWithinSetScoreField:
            print(self.TBWithinSetScoreField.text!)
        case self.TBWithinSetPointsField:
            print(self.TBWithinSetPointsField.text!)
        case self.TBFinalSetField:
            print(self.TBFinalSetField.text!)
        default:
            return
        }
    }
}

extension MatchViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case gamesPicker:
            return noOfGamesData.count
        case deucePicker:
            return deuceData.count
        case TBWithinSetPicker:
            return TBat0.count
        case TBWithinSetPointsPicker:
            return 3
        case TBFinalSetPicker:
            return 3
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case gamesPicker:
            return String(noOfGamesData[row])
        case deucePicker:
            return deuceData[row]
        case TBWithinSetPicker:
            switch noOfGamesField.text {
            case "4":
                return TBat0[row]
            case "6":
                return TBat1[row]
            case "8":
                return TBat2[row]
            default:
                return TBat2[row]
            }
        case TBWithinSetPointsPicker:
            return String(TB[row])
        case TBFinalSetPicker:
            return String(TB[row])
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case gamesPicker:
            if row == 0{
                self.noOfGamesField.text = nil
            } else{
                self.noOfGamesField.text = noOfGamesData[row]
                self.TBWithinSetScoreField.text = nil
            }
        case deucePicker:
            if row == 0{
                self.deuceField.text = nil
            } else{
                self.deuceField.text = deuceData[row]
            }
        case TBWithinSetPicker:
            if row == 0{
                self.TBWithinSetScoreField.text = nil
            }else{
                switch noOfGamesField.text {
                case "4":
                    self.TBWithinSetScoreField.text = TBat0[row]
                case "6":
                    self.TBWithinSetScoreField.text = TBat1[row]
                case "8":
                    self.TBWithinSetScoreField.text = TBat2[row]
                default:
                    return self.TBWithinSetScoreField.text = TBat0[row]
                }
            }
        case TBWithinSetPointsPicker:
            if row == 0{
                self.TBWithinSetPointsField.text = nil
            } else{
                self.TBWithinSetPointsField.text = TB[row]
            }
        case TBFinalSetPicker:
            if row == 0 {
                self.TBFinalSetField.text = nil
            } else{
                self.TBFinalSetField.text = TB[row]
            }
        default: break
        }
    }
    
    
    
}

