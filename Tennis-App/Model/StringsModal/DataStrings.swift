//
//  StringingHistoryData.swift
//  Tennis-App
//
//  Created by Pranav  Suri on 16/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import UIKit

class DataStrings: NSObject {

	var racket = ""
	var crossTension : Any
	var mainsTension : Any
	var stringBrand = ""
	var stringName = ""
	override init() {
		crossTension = 0
		mainsTension = 0
	}
	init(json:[String:Any]) {
		racket = json["racket"] as! String
		crossTension = json["crossTension"] ?? 0
		mainsTension = json["mainsTension"] ?? 0
		stringBrand = json["stringBrand"] as! String
		stringName = json["stringName"] as! String
	}
}


//created = "<FIRTimestamp: seconds=1589626856 nanoseconds=636107000>";
//crossTension = 23;
//date = "17 May 2020";
//mainsTension = 23;
//racket = "ab did";
//stringBrand = "ab did";
//stringName = "ab did";
