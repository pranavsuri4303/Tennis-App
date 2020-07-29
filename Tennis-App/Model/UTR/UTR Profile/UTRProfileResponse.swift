//
//  UTRProfileResponse.swift
//  Tennis-App
//
//  Created by Pranav  Suri on 6/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import Foundation

struct UTRProfile: Decodable {
	let firstName: String
	let lastName: String
    
    var playerName: String{
        return "\(firstName) \(lastName)"
    }
    
	let singlesUtr: Double
	let ratingStatusSingles: String
	let ratingProgressSingles: String

	let doublesUtr: Double
	let ratingStatusDoubles: String
	let ratingProgressDoubles: String

	let nationality: String
}
