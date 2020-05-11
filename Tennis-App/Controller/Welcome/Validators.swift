//
//  Validators.swift
//  Tennis-App
//
//  Created by Pranav  Suri on 11/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import Foundation
import Navajo_Swift

struct Validators {

	func isValidEmail(_ email: String) -> Bool {
		let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
		let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		return emailPred.evaluate(with: email)
	}

	let password = PasswordValidator(rules: [LengthRule(min: 8, max: 24), RequiredCharacterRule(preset: .decimalDigitCharacter)])

	let YOB = PasswordValidator(rules: [LengthRule(min: 4, max: 4), AllowedCharacterRule(allowedCharacters: .decimalDigits)])
}
